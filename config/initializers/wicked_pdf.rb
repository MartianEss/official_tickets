wkhtmltopdf = (Rails.env == 'production' or Rails.env == 'staging') ? Rails.root.join('bin', 'wkhtmltopdf-amd64').to_s : '/usr/local/bin/wkhtmltopdf'
WickedPdf.config = {
  :exe_path => wkhtmltopdf,
  :print_media_type => true,
  :page_size => 'A4',
  :margin => {:left => 0, :right => 0}
}
