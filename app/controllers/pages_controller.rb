class PagesController < ApplicationController
  def homepage
    @recent_excel_sheets = ExcelSheet.all
  end

  def download_excel_sheet
  end
  def validate
    redirect_to download_report_path
  end

  def generate

    workbook = RubyXL::Parser.parse('app/assets/images/SampleExcel.xlsx')
    worksheet = workbook[0]
    category_column_index = 22
    comments_column_index = 36

    data_groups = {}

    worksheet.each_with_index do |row, index|
      next if index == 0  # Skip the header row

      category_cell = row[category_column_index]
      category = category_cell && category_cell.value

      next if category.nil? || category.to_s.empty?

      # Check if the category group already exists, if not, create it
      #data_groups[category] ||= {}

      # Get the product name from the "Product" column
      comment_cell = row[comments_column_index]
      comment_name = comment_cell && comment_cell.value

      # Add the product name to the corresponding category group
      # data_groups[category][comment_name] ||= []
      # data_groups[category][comment_name] << comment_name unless comment_name.nil? || comment_name.empty?

      data_groups[category] ||= []
      data_groups[category] << comment_name unless comment_name.nil? || comment_name.empty?
      #data_groups[category] << comment_name

    end

    data_groups.each do |category, comments|
      puts "Question ID: #{category}"
      comments.each do |comment, _|
        if !comment.to_s.empty?
          puts "Comments: #{comment}"
        end
      end
      puts "-----------------------"

    end

    new_workbook = RubyXL::Workbook.new
    new_worksheet = new_workbook[0]


    row_index = 0

    data_groups.each do |category, comments|
      new_worksheet.add_cell(row_index, 0, 'Category: ' + category.to_s)
      row_index += 1

      comments.each do |comment|
        new_worksheet.add_cell(row_index, 0, 'Comment: ' + comment.to_s)
        row_index += 1
      end

      row_index += 1
    end


    new_workbook.write('public/excel_files/grouped_data.xlsx')

    response_index = 29


    response_values = []


    worksheet.each do |row|
      cell = row[response_index]
      cell_value = cell && cell.value
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
      send_file excel_file_path, filename: 'grouped_data.xlsx', type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    else
      flash[:alert] = 'The Excel file does not exist.'
      redirect_to root_path
    end
  end
end
