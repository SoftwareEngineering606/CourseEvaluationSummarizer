# frozen_string_literal: true
class PagesController < ApplicationController
  def homepage
    @recent_processed_sheets = ProcessedSheet.all
  end

  def download_processed_sheet
    #    @processed_sheet = ProcessedSheet.find_by(name: params[:name])

    #    excel_file_path = Rails.root.join('public', 'excel_files', "#{@processed_sheet.name}.xlsx")

    #    if File.exist?(excel_file_path)
    #      send_file excel_file_path, filename: "#{@processed_sheet.name}.xlsx",
    #                                 type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    #    else
    #      flash[:alert] = 'The Excel file does not exist.'
    #      redirect_to root_path
    #    end
  end

  def validate
    redirect_to download_report_path
  end


  def generate
    #puts @excel_sheet
    directory = Rails.root.join('public', 'uploads')
    excel_files = Dir["#{directory}/*.xlsx"]

    average_hash = {}
    median_hash = {}
    mode_hash = {}
    data_groups = {}

    excel_files.each do |file_path|
      begin
    # Uploaded file
    #workbook = RubyXL::Parser.parse('public/uploads/SampleExcel.xlsx')
    workbook = RubyXL::Parser.parse(file_path)
    worksheet = workbook[0]
    category_column_index = 25
    comments_column_index = 36
    question_response_value = 29


    category_statistics = {}

    worksheet.each_with_index do |row, index|
      next if index.zero? # Skip the header row

      category_cell = row[category_column_index]
      category = category_cell&.value

      next if category.nil? || category.to_s.empty?

      comment_cell = row[comments_column_index]
      comment_name = comment_cell&.value

      data_groups[category] ||= []
      data_groups[category] << comment_name unless comment_name.nil? || comment_name.empty?

      question_value_cell = row[question_response_value]
      response_value = question_value_cell&.value

      category_statistics[category] ||= { 'Response Values' => [] }
      category_statistics[category]['Response Values'] << response_value.to_f
    end

    # Calculate category statistics (average, median, and mode) for each category
    data_groups.each do |category, _comments|
      response_values = category_statistics[category]['Response Values']

      average = response_values.reduce(0.0, :+) / response_values.length.to_f

      sorted_values = response_values.sort
      n = sorted_values.length
      median = n.odd? ? sorted_values[n / 2] : (sorted_values[n / 2 - 1] + sorted_values[n / 2]) / 2.0

      value_counts = Hash.new(0)
      response_values.each { |value| value_counts[value] += 1 }
      max_count = value_counts.values.max
      mode = value_counts.key(max_count)

      category_statistics[category] = {
        'Average' => average,
        'Median' => median,
        'Mode' => mode
      }
    end

    data_groups.each do |category, comments|
      category_stats = category_statistics[category]

      average_hash[category] ||= []
      average_hash[category] << category_stats['Average']

      median_hash[category] ||= []
      median_hash[category] << category_stats['Median']

      mode_hash[category] ||= []
      mode_hash[category] << category_stats['Mode']

    end

      rescue StandardError => e
        # Handle any errors that occur during parsing
        puts "Error parsing #{file_path}: #{e.message}"
      end
    end

    new_workbook = RubyXL::Workbook.new

    i = 1
    data_groups.each do |category, comments, index|
      # next if comments.empty?

      new_worksheet = new_workbook.add_worksheet(index)

      new_worksheet.sheet_name = "Question "+ (i).to_s
      i = i+1
      row_index = 0

      new_worksheet.add_cell(row_index, 0, category.to_s)
      new_worksheet.add_cell(row_index, 1, 'Perfect Score')
      new_worksheet.add_cell(row_index, 2, 'Average')
      new_worksheet.add_cell(row_index, 3, 'Median')
      new_worksheet.add_cell(row_index, 4, 'Mode')

      row_index = 1


      # Add the calculated statistics for the category
      # category_stats = category_statistics[category]
      # new_worksheet.add_cell(row_index, 2, category_stats['Average'])
      # new_worksheet.add_cell(row_index, 3, category_stats['Median'])
      # new_worksheet.add_cell(row_index, 4, category_stats['Mode'])

      average_hash[category].each do |avg|
        puts('mean')
        puts(avg)
        new_worksheet.add_cell(row_index, 1, '4')
        new_worksheet.add_cell(row_index, 2, avg.to_s)
        row_index += 1
      end

      row_index = 1
      median_hash[category].each do |median|
        puts('median')
        puts(median)
        new_worksheet.add_cell(row_index, 3, median.to_s)
        row_index += 1
      end

      row_index = 1
      mode_hash[category].each do |mode|
        puts('mode')
        puts(mode)
        new_worksheet.add_cell(row_index, 4, mode.to_s)
        row_index += 1
      end

      row_index = 4

      comments.each do |comment|
        new_worksheet.add_cell(row_index, 0, comment.to_s)
        row_index += 1
      end
      
      # Make a chatgpt call here to summarize commemnts in some specific word count range and add it to the list
      input_text = comments.join(" ")
      summarizer = SummarizeService.new(input_text)
      summary = summarizer.summarize_text
      row_index+=1
      new_worksheet.add_cell(row_index, 0, 'SUMMARY')
      row_index+=1
      new_worksheet.add_cell(row_index, 0, summary)


    end

    worksheet_to_delete = new_workbook[0]
    new_workbook.worksheets.delete(worksheet_to_delete)

    #file_name = File.basename(file_path)
    file_name = "Sheet" + "-#{Time.now.to_i}" + ".xlsx"
    session[:file] = "Processed_"+file_name
    processed_file_name = "Processed_"+file_name
    processed_file_path = Rails.root.join('public', 'excel_files', processed_file_name)
    new_workbook.write(processed_file_path)

    processed_sheet = [ { name: processed_file_name, description: 'Description for '+ processed_file_name, report_path: processed_file_path } ]
    ProcessedSheet.create(processed_sheet)



    # new_workbook = RubyXL::Workbook.new
    # new_worksheet = new_workbook[0]

    # row_index = 0

    # data_groups.each do |category, comments|
    #   new_worksheet.add_cell(row_index, 0, "Category: #{category}")
    #   row_index += 1

    #   comments.each do |comment|
    #     new_worksheet.add_cell(row_index, 0, "Comment: #{comment}")
    #     row_index += 1
    #   end

    #   row_index += 1
    # end

    # new_workbook.write('public/excel_files/grouped_data.xlsx')

    # response_index = 29
    #
    # response_values = []
    #
    # worksheet.each do |row|
    #   cell = row[response_index]
    #   cell_value = cell&.value
    #   response_values << cell_value
    # end
    #
    # response_values = response_values.compact.map(&:to_i)
    #
    # mean = response_values.sum.to_f / response_values.length
    # puts "Mean: #{mean}"
    #
    # sorted_data = response_values.sort
    # if sorted_data.length.odd?
    #   median = sorted_data[sorted_data.length / 2]
    # else
    #   middle1 = sorted_data[(sorted_data.length / 2) - 1]
    #   middle2 = sorted_data[sorted_data.length / 2]
    #   median = (middle1 + middle2) / 2.0
    # end
    #
    # puts "Median: #{median}"
    #
    # value_count = Hash.new(0)
    #
    # response_values.each { |value| value_count[value] += 1 }
    #
    # max_count = value_count.values.max
    # mode = value_count.select { |_value, count| count == max_count }.keys
    #
    # puts "Mode: #{mode}"

    redirect_to download_report_path
  end

  def download
    name = session[:file]
    if name.nil?
      name = 'grouped_data.xlsx'
    end
    excel_file_path = Rails.root.join('public', 'excel_files', name)
        if File.exist?(excel_file_path)
          send_file excel_file_path, filename: name,
                     type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
         else
          flash[:alert] = 'The Excel file does not exist.'
          redirect_to root_path
    end
  end
end
