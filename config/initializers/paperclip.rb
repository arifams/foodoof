# needed for paperclip international user
Paperclip::Attachment.default_options[:url] = ':foodoof.s3.amazonaws.com'
Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'