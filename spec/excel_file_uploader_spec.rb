require 'rails_helper'
require 'carrierwave/test/matchers'

describe ExcelFileUploader do
  let(:uploader) { ExcelFileUploader.new(double('model'), 'mounted_as') }

  it 'checks that the ExcelFileUploader class exists' do
    expect(uploader).to be_a(ExcelFileUploader)
  end

  it 'checks that the store_dir method exists' do
    expect(uploader).to respond_to(:store_dir)
  end
end