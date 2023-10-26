# frozen_string_literal: true

class PagesController < ApplicationController
  def homepage
    @recent_excel_sheets = ExcelSheet.all
  end

  def download_excel_sheet; end

  def validate
    redirect_to download_report_path
  end

  def generate
    puts @excel_sheet
    workbook = RubyXL::Parser.parse('app/assets/images/SampleExcel.xlsx')
    worksheet = workbook[0]
    category_column_index = 25
    comments_column_index = 36
    question_response_value = 29

    data_groups = {}
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
    data_groups.each do |category, comments|
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

    new_workbook = RubyXL::Workbook.new

    data_groups.each do |category, comments, index|
      next if comments.empty?
      new_worksheet = new_workbook.add_worksheet(index)
    
      row_index = 0

      new_worksheet.add_cell(row_index, 0, "#{category}")
      new_worksheet.add_cell(row_index, 1, "Perfect Score")
      new_worksheet.add_cell(row_index, 2, "Average")
      new_worksheet.add_cell(row_index, 3, "Median")
      new_worksheet.add_cell(row_index, 4, "Mode")

      row_index = 1
      new_worksheet.add_cell(row_index, 1, "4")
      # Add the calculated statistics for the category
      category_stats = category_statistics[category]
      new_worksheet.add_cell(row_index, 2, category_stats['Average'])
      new_worksheet.add_cell(row_index, 3, category_stats['Median'])
      new_worksheet.add_cell(row_index, 4, category_stats['Mode'])

      row_index = 2

      comments.each do |comment|
        new_worksheet.add_cell(row_index, 0, "#{comment}")
        row_index += 1
      end
    end

new_workbook.write('public/excel_files/grouped_data.xlsx')

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

    response_index = 29

    response_values = []

    worksheet.each do |row|
      cell = row[response_index]
      cell_value = cell&.value
      response_values << cell_value
    end

    response_values = response_values.compact.map(&:to_i)

    mean = response_values.sum.to_f / response_values.length
    puts "Mean: #{mean}"

    sorted_data = response_values.sort
    if sorted_data.length.odd?
      median = sorted_data[sorted_data.length / 2]
    else
      middle1 = sorted_data[(sorted_data.length / 2) - 1]
      middle2 = sorted_data[sorted_data.length / 2]
      median = (middle1 + middle2) / 2.0
    end

    puts "Median: #{median}"

    value_count = Hash.new(0)

    response_values.each { |value| value_count[value] += 1 }

    max_count = value_count.values.max
    mode = value_count.select { |_value, count| count == max_count }.keys

    puts "Mode: #{mode}"

    redirect_to download_report_path
  end

  def download
    excel_file_path = Rails.root.join('public', 'excel_files', 'grouped_data.xlsx')

    if File.exist?(excel_file_path)
      send_file excel_file_path, filename: 'grouped_data.xlsx',
                                 type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    else
      flash[:alert] = 'The Excel file does not exist.'
      redirect_to root_path
    end
  end
end
