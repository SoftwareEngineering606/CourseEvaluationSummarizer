# spec/application_job_spec.rb
require 'rails_helper'

RSpec.describe ApplicationJob, type: :job do
  it 'inherits from ActiveJob::Base' do
    expect(ApplicationJob.ancestors).to include(ActiveJob::Base)
  end
end