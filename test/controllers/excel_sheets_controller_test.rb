require "test_helper"

class ExcelSheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get excel_sheets_index_url
    assert_response :success
  end

  test "should get show" do
    get excel_sheets_show_url
    assert_response :success
  end

  test "should get new" do
    get excel_sheets_new_url
    assert_response :success
  end

  test "should get edit" do
    get excel_sheets_edit_url
    assert_response :success
  end

  test "should get create" do
    get excel_sheets_create_url
    assert_response :success
  end

  test "should get update" do
    get excel_sheets_update_url
    assert_response :success
  end

  test "should get destroy" do
    get excel_sheets_destroy_url
    assert_response :success
  end
end
