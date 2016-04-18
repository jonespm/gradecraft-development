# Meant for inclusion in ActiveRecord files that are persisting CarrierWave objects via S3
module S3Manager
  module Carrierwave
    extend ActiveSupport::Concern

    # Legacy submission files were handled by S3 direct upload and we stored their
    # Amazon key in the "filepath" field. Here we check if it has a value, and if
    # so we use this to retrieve our secure url. If not, we use the path supplied by
    # the carrierwave uploader

    attr_accessor :process_file_upload, :store_dir

    included do
      before_create :cache_store_dir
    end

    include S3Manager::Basics

    def url
      if s3_object
        s3_object.presigned_url(:get, expires_in: 900).to_s
      end
    end

    def s3_object
      bucket.object(s3_object_file_key)
    end

    def stream_s3_object
      streamable_object = get_object(s3_object_file_key)
      return nil unless streamable_object
      streamable_object.body.read
    end

    def delete_from_s3
      s3_object.delete
    end

    def exists_on_s3?
      s3_object.exists?
    end

    def s3_object_file_key
      if store_dir && mounted_filename
        cached_file_path # build a full file path from cached #store_dir and #filename attributes on the FooFile record
      elsif filepath_includes_filename?
        CGI::unescape(filepath)
      else
        file.path
      end
    end

    def cached_file_path
      @cached_file_path ||= [ store_dir, mounted_filename ].join("/")
    end

    def mounted_filename
      read_attribute(file.mounted_as)
    end

    def filepath_includes_filename?
      filepath.present? && filepath.include?(filename)
    end

    protected

    def cache_store_dir
      self[:store_dir] = file.store_dir
    end
  end
end
