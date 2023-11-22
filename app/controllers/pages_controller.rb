require 'rubyXL'
require 'rubyXL/convenience_methods/cell'
require 'rubyXL/convenience_methods/color'
require 'rubyXL/convenience_methods/font'
require 'rubyXL/convenience_methods/workbook'
require 'rubyXL/convenience_methods/worksheet'
require 'rubyXL/convenience_methods'


class PagesController < ApplicationController
  def homepage
    # @recent_processed_sheets = ProcessedSheet.all
    #@processed_sheet = ProcessedSheet.find(params[:id])
    @recent_processed_sheets = ProcessedSheet.order(created_at: :desc).limit(3)
    @processed_sheet = ProcessedSheet.order(created_at: :desc).limit(5)
  end

  def download_processed_sheet
    if params[:report_id_final]
      processed_sheet = ProcessedSheet.find_by(report_id_final: params[:report_id_final])
      if processed_sheet
        fileName = processed_sheet.name
        file_path = Rails.root.join('public', 'zip_all_files', fileName)
        if File.exist?(file_path)
          send_file file_path,
                    filename: "#{params[:report_id_final]}.zip",
                    type: 'application/zip',
                    disposition: 'attachment'
        else
          flash[:alert] = "File not found"
          redirect_to root_path
        end
      else
        flash[:alert] = "Not Processed sheet found"
        redirect_to root_path
      end
    else
      flash[:alert] = "Invalid request"
      redirect_to root_path
    end
  end

  def validate
    redirect_to download_report_path
  end


  def generate

    labels=session[:labels]

    # Delete all existing Excel files in the directory
    del_directory = Rails.root.join('public', 'processed')
    existing_excel_files = Dir["#{del_directory}/*.xlsx"]
    existing_excel_files.each { |file| File.delete(file) }

    numberOfResp_hash = {}


 labels.each do |label|


    numberOfResp = 0
    directory = Rails.root.join('public', 'uploads')
    excel_files = Dir["#{directory}/*"+label+".xlsx"]

    average_hash = {}
    median_hash = {}
    mode_hash = {}
    perfect_score_hash = {}
    data_groups = {}

    excel_files.each do |file_path|
      begin
    # Uploaded file
    #workbook = RubyXL::Parser.parse('public/uploads/SampleExcel.xlsx')
    responseCount = []
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
      responseCount.push(response_values.size)

      average = response_values.reduce(0.0, :+) / response_values.length.to_f

      sorted_values = response_values.sort
      n = sorted_values.length
      median = n.odd? ? sorted_values[n / 2] : (sorted_values[n / 2 - 1] + sorted_values[n / 2]) / 2.0

      value_counts = Hash.new(0)
      response_values.each { |value| value_counts[value] += 1 }
      max_count = value_counts.values.max
      mode = value_counts.key(max_count)


      perfect_score = response_values.max

      category_statistics[category] = {
        'Average' => average,
        'Median' => median,
        'Mode' => mode,
        'Perfect_score' => perfect_score
      }
    end



    numberOfResp= numberOfResp+responseCount.max

    data_groups.each do |category, comments|
      category_stats = category_statistics[category]

      average_hash[category] ||= []
      average_hash[category] << category_stats['Average']

      median_hash[category] ||= []
      median_hash[category] << category_stats['Median']

      mode_hash[category] ||= []
      mode_hash[category] << category_stats['Mode']

      perfect_score_hash[category] ||= []
      perfect_score_hash[category] << category_stats['Perfect_score']

    end



      rescue StandardError => e
        # Handle any errors that occur during parsing
        puts "Error parsing #{file_path}: #{e.message}"
      end
    end

    puts('Final Max')
    numberOfResp_hash[label] = numberOfResp
    numberOfResp = 0

    new_workbook = RubyXL::Workbook.new

    data_groups = data_groups.sort.to_h

    i = 1
    data_groups.each do |category, comments, index|
      # next if comments.empty?

      new_worksheet = new_workbook.add_worksheet(index)
      sheet_name = "Question"

      puts(category)
      if category.include?('understood')
        sheet_name = "Understood Expectation"
      elsif category.include?('participation')
        sheet_name = "Engagement and Participation"
      elsif category.include?('Grade')
        sheet_name = "Grade"
      elsif category.include?('feedback')
        sheet_name = "Feedback"
      elsif category.include?('critical thinking')
        sheet_name = "Critical Thinking"
      elsif category.include?('perspectives')
        sheet_name = "Diverse ideas and Perspective"
      elsif category.include?('required')
        sheet_name = "Course Importance"
      elsif category.include?('comments')
        sheet_name = "General Comments"
      elsif category.include?('organization')
        sheet_name = "Organization of Course"
      elsif category.include?('responsibility')
        sheet_name = "Encouraged Responsibility"
      elsif category.include?('learning environment')
        sheet_name = "Learning Environment"
      elsif category.include?('teaching')
        sheet_name = "Teaching Methods"
      elsif category.include?('objectives')
        sheet_name = "Objectives and Outcomes"
      end

      new_worksheet.sheet_name = sheet_name
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


      max_values = {}
      perfect_score_hash.each do |_category, values|
        max_value = values.max
        max_values[_category] = max_value
      end


      average_hash[category].each do |avg|
        # puts('mean')
        # puts(avg)
        new_worksheet.add_cell(row_index, 1, max_values[category])
        new_worksheet.add_cell(row_index, 2, avg.to_s)
        row_index += 1
      end

      row_index = 1
      median_hash[category].each do |median|
        # puts('median')
        # puts(median)
        new_worksheet.add_cell(row_index, 3, median.to_s)
        row_index += 1
      end

      row_index = 1
      mode_hash[category].each do |mode|
        # puts('mode')
        # puts(mode)
        new_worksheet.add_cell(row_index, 4, mode.to_s)
        row_index += 1
      end

      row_index = 4

      # #Remove duplicate comments 
      # duplicate_service = DuplicateService.new(comments)
      # unique_comments = duplicate_service.remove_duplicates
      
      comments.each do |comment|
        new_worksheet.add_cell(row_index, 0, comment.to_s)
        row_index += 1
      end
      
      # Make a chatgpt call here to summarize commemnts in some specific word count range and add it to the list
      if comments.length > 0
        input_text = "Summarize the following in 3 4 lines" + comments.join(" ")
        # summarizer = ChatgptService.new(input_text)
        # summary = summarizer.call
        summary = "Dummy summary"
        row_index += 1
        new_worksheet.add_cell(row_index, 0, 'SUMMARY')
        row_index += 1
        new_worksheet.add_cell(row_index, 0, summary)
      end
    end

    worksheet_to_delete = new_workbook[0]
    new_workbook.worksheets.delete(worksheet_to_delete)

    #file_name = File.basename(file_path)
    file_name = "Sheet" + "-#{Time.now.to_i}_" + label + ".xlsx"
    session[:file] = "Processed_"+file_name
    processed_file_name = "Processed_"+file_name




    processed_file_path = Rails.root.join('public', 'processed', processed_file_name)
    new_workbook.write(processed_file_path)

 end

    session[:numberOfResp] = numberOfResp_hash
    redirect_to download_report_path
  end


  def compare

    directory = Rails.root.join('public', 'processed')
    excel_files = Dir["#{directory}/*.xlsx"]

    new_workbook = RubyXL::Workbook.new
    new_sheet = new_workbook[0]
    new_sheet.sheet_name = "Comparison"
    added_cell = new_sheet.add_cell(0, 0, "QUESTION NO.")
    new_sheet.change_column_width(0, 20)
    added_cell.change_font_bold(bolded = true)

    added_cell = new_sheet.add_cell(0, 1, "QUESTIONS")
    added_cell.change_font_bold(bolded = true)

    added_cell = new_sheet.add_cell(0, 4, "PERFECT SCORE")
    added_cell.change_font_bold(bolded = true)
    new_sheet.change_column_width(4, 30)

    added_cell = new_sheet.add_cell(0, 5, "% IMPROVEMENT")
    added_cell.change_font_bold(bolded = true)
    new_sheet.change_column_width(5, 30)

    question_column = 0
    row_index=3

    # labels=session[:labels]

    label_column = 6
    column_index = 6
    current_color = "b2e7b2"
    # labels.each do |label|
    #   new_sheet.add_cell(0, label_column, label)
    #   label_column = label_column + 2
    # end



    excel_files.each_with_index do |file_path, file_index|
      begin
        workbook = RubyXL::Parser.parse(file_path)
        sheets_list = workbook.worksheets
        question_increment = 1




        sheets_list.each do |sheet|

          perfect_score = 4
          short_summary = ''
          average_list = []
          median_list = []
          mode_list = []

          sheet.each_with_index do |row, index|
             if index.zero?
               question_cell = row[question_column]
               question_string = question_cell&.value
               new_sheet.add_cell(row_index, 0, question_increment.to_s)
               question_increment = question_increment + 1
               new_sheet.add_cell(row_index, 1, question_string)


             else

               summary = row&.[](0)
               summary_value = summary&.value

               if summary_value && !summary_value.to_s.empty?
                 short_summary = summary_value
               end

               metric = row&.[](1)

               metric_value = metric&.value

               if metric_value && !metric_value.to_s.empty?

                 perfect_score = metric_value
               end

               metric = row&.[](2)
               metric_value = metric&.value

               if metric_value && !metric_value.to_s.empty?

                 average_list.push(metric_value)
               end

               metric = row&.[](3)
               metric_value = metric&.value

               if metric_value && !metric_value.to_s.empty?

                 median_list.push(metric_value)
               end

               metric = row&.[](4)
               metric_value = metric&.value

               if metric_value && !metric_value.to_s.empty?

                 mode_list.push(metric_value)
               end


             end

          end

          # puts('HELLOOOOO')
          # puts('row Index')
          # puts(row_index)

          average_list = average_list.map(&:to_f)
          average = average_list.reduce(0.0, :+) / average_list.length.to_f

          median_list = median_list.map(&:to_f)
          sorted_values = median_list.sort
          n = sorted_values.length
          median = n.odd? ? sorted_values[n / 2] : (sorted_values[n / 2 - 1] + sorted_values[n / 2]) / 2.0

          mode = mode_list.map(&:to_f).max

          # puts('Perfect score')
          # puts(perfect_score)
          #
          # puts('Average')
          # puts(average)
          #
          # puts('median')
          # puts(median)
          #
          # puts('mode')
          # puts(mode)

          if file_index.zero?
          new_sheet.add_cell(row_index, 4 , perfect_score)
          end

          #puts('summary')
          #puts(short_summary)
          cell1 = new_sheet.add_cell(row_index, column_index , average)
          cell2 = new_sheet.add_cell(row_index, column_index+1 , median)
          cell3 = new_sheet.add_cell(row_index, column_index+2 , mode)
          cell4 = new_sheet.add_cell(row_index, column_index+3 , short_summary)
          cell1.set_number_format('0.00')
          cell2.set_number_format('0.00')
          cell3.set_number_format('0.00')

          cell1.change_horizontal_alignment(alignment = 'center')
          cell2.change_horizontal_alignment(alignment = 'center')
          cell3.change_horizontal_alignment(alignment = 'center')


          #column_index = 6
          row_index = row_index + 2

     end



      new_sheet.change_column_width(1, 250)

        #Extract the last 4 characters of the file name
      file_name = File.basename(file_path, File.extname(file_path))

      last_four_characters = file_name[-4..-1]
      added_cell = new_sheet.add_cell(0,label_column , last_four_characters + "-Average")
      added_cell.change_horizontal_alignment(alignment = 'center')
      added_cell.change_font_bold(bolded = true)

      new_sheet.change_column_width(label_column, 30)
      label_column = label_column + 1
      added_cell = new_sheet.add_cell(0,label_column , last_four_characters + "-Median")
      added_cell.change_horizontal_alignment(alignment = 'center')
      added_cell.change_font_bold(bolded = true)

      new_sheet.change_column_width(label_column, 30)
      label_column = label_column + 1
      added_cell = new_sheet.add_cell(0,label_column , last_four_characters + "-Mode")
      added_cell.change_horizontal_alignment(alignment = 'center')
      added_cell.change_font_bold(bolded = true)

      new_sheet.change_column_width(label_column, 30)
      label_column = label_column + 1
      added_cell = new_sheet.add_cell(0,label_column , last_four_characters + "-Summary")
      added_cell.change_font_bold(bolded = true)
      new_sheet.change_column_width(label_column, 30)


        columns_to_color = []
        columns_to_color.push(column_index)
        #column_color = RubyXL::Color.new(200, 200, 200)


        # new_sheet.each do |sheet_row|
        #   columns_to_color.each do |column|
        #     cell = sheet_row[column]
        #     cell.change_fill("008000")
        #   end
        # end


        start_row = 0
        end_row = row_index
        start_column = column_index
        end_column = column_index + 4

        #Iterate through rows and apply color to cells in the specified range
        # (new_sheet.sheet_data[start_row..end_row] || []).each do |sheet_row|
        #   next unless sheet_row
        #   (sheet_row.cells[start_column..end_column] || []).each do |cell|
        #     # Apply the color to the cell's style
        #     cell.change_fill(current_color)
        #   end
        # end


        for row_index_new in start_row...end_row
           if new_sheet[row_index_new].nil?
            for column_index_new in start_column...end_column
              new_sheet.add_cell(row_index_new,column_index_new,"")
            end
           end
        end

        for row_index_new in start_row...end_row
            for column_index_new in start_column...end_column
              if new_sheet[row_index_new][column_index_new].nil?
              new_sheet.add_cell(row_index_new,column_index_new,"")
            end
          end
        end

        #Iterate through rows and apply color to cells in the specified range
        (new_sheet.sheet_data[start_row..end_row] || []).each do |sheet_row|
           next unless sheet_row
          (sheet_row.cells[start_column..end_column] || []).each do |cell|
            # Apply the color to the cell's style
            cell.change_fill(current_color)
            cell.change_border(:top, :thin)
            cell.change_border(:left, :thin)
            cell.change_border(:right, :thin)
            cell.change_border_color(:top, 'A9A9A9')
            cell.change_border_color(:left, 'A9A9A9')
            cell.change_border_color(:right, 'A9A9A9')

          end
        end



        if current_color == "b2e7b2"
          current_color = "ffb65c"
        else
          current_color = "b2e7b2"
        end


        row_index=3
      label_column = label_column + 3
      column_index = column_index + 6


      rescue StandardError => e
        # Handle any errors that occur during parsing
        puts "Error parsing #{file_path}: #{e.message}"
      end

    end

    all_sem_average = []
    starting_row = 3
    ending_row = 28
    starting_column = 6

    # while !new_sheet[starting_row] && !new_sheet[starting_row][starting_column].nil?
    #
    #
    # end

    value_improvement = 0
    improvement_text = ""

    #need_to_change
    while starting_row<=ending_row

      while  !new_sheet[starting_row].nil? && !new_sheet[starting_row][starting_column].nil?
        all_sem_average.push(new_sheet[starting_row][starting_column].value)
        starting_column = starting_column + 6
      end

      max_value = all_sem_average.max
      min_value = all_sem_average.min

      if max_value == min_value
        value_improvement = 0
      else
        value_improvement = ((max_value-min_value)/min_value) * 100
        value_improvement = sprintf('%.2f', value_improvement)
      end

      if value_improvement == 0
        improvement_text = "NA"
      else
        improvement_text = value_improvement.to_s+'%'
      end

      cell=new_sheet.add_cell(starting_row,5,improvement_text)
      cell.set_number_format('00.00%')

      all_sem_average = []
      starting_row = starting_row + 2
      starting_column = 6
    end

    puts(session[:numberOfResp])

    sheetResp = new_workbook.add_worksheet('# of Respondents')

    sheetResp.add_cell(0, 0, "Semester")
    sheetResp.add_cell(0, 1, "# of Respondents")
    sheetResp.change_row_bold(0,true)
    sheetResp.change_column_width(0, 20)
    sheetResp.change_column_width(1, 20)

    row_value = 2
    resp_hash = session[:numberOfResp]

    resp_hash.each do |key, value|
      sheetResp.add_cell(row_value, 0, key.to_s)
      sheetResp.add_cell(row_value, 1, value.to_s)
      row_value = row_value + 1
    end


    final_file_name = 'Final_Processed_'+"-#{Time.now.to_i}" + '.xlsx'
    file_path = Rails.root.join('public', 'processed_final',final_file_name )
    new_workbook.write(file_path)
    session[:processedFile] = final_file_name

    zip_file_path = Rails.root.join('public','zip_intermediate_processed','processed_files'+"-#{Time.now.to_i}"+'.zip')
    Zip::File.open(zip_file_path, Zip::File::CREATE) do |zip_file|
      excel_files.each do |file_path|
        # Extract the file name from the path
        file_name = File.basename(file_path)
        zip_file.add(file_name, file_path)
      end
    end

    session[:processed_intermediate_zip] = zip_file_path

    all_files = excel_files
    all_files.push(file_path)


    zip_name = 'Comparison_Zip'+"-#{Time.now.to_i}"+'.zip'
    zip_file_path = Rails.root.join('public','zip_all_files',zip_name)
    Zip::File.open(zip_file_path, Zip::File::CREATE) do |zipfile|
      all_files.each do |file_path|
        # Extract the file name from the path
        file_name = File.basename(file_path)
        zipfile.add(file_name, file_path)
      end
    end

    session[:all_files_zip] = zip_file_path

    processed_zip = [ { name: zip_name, description: 'Description for '+ zip_name, report_path: zip_file_path } ]
    ProcessedSheet.create(processed_zip)

    redirect_to download_report_path

    end
  def download
    name = session[:processedFile]
    if name.nil?
      name = 'grouped_data.xlsx'
    end
    excel_file_path = Rails.root.join('public', 'processed_final', name)
        if File.exist?(excel_file_path)
          send_file excel_file_path, filename: name,
                     type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
         else
          flash[:alert] = 'The Excel file does not exist.'
          redirect_to root_path
    end
  end


  def downloadIntermediate
    path = session[:processed_intermediate_zip]
    puts "here"
    puts path
    if path.nil?
      path = 'processed_files.zip'
    end
    zip_file_path = Rails.root.join('public', 'zip_intermediate_processed', path)
    puts "here2"
    puts zip_file_path
    if File.exist?(zip_file_path)
      send_file zip_file_path, filename: path, type: 'application/zip'
    else
      flash[:alert] = 'The zip file does not exist.'
      redirect_to root_path
    end
  end

end
