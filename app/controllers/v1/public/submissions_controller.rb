class V1::Public::SubmissionsController < ApplicationController
  def index
    @submissions = Public::Submission.all
    render :index
  end
end
