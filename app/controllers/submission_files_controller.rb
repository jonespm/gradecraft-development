class SubmissionFilesController < ApplicationController
  def download
    authorize! :download, presenter.submission_file

    # let's use the object_stream here because there's no reason to hit S3 twice
    if presenter.submission_file_streamable?
      send_data(presenter.stream_submission_file, filename: presenter.filename)
      render nothing: true
    else
      presenter.mark_submission_file_missing
      flash[:alert] = "The requested file was not found on the server."
      redirect_to request.referrer
    end
  end

  def presenter
    @presenter ||= SubmissionFilesPresenter.new params: params
  end
end
