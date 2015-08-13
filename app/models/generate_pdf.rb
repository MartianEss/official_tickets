class GeneratePdf < Struct.new(:order_id)

  # delayed_job automatically looks for a "perform" method
  def perform
    # create an instance of ActionView, so we can use the render method outside of a controller
    av = ActionView::Base.new()
    av.view_paths = ActionController::Base.view_paths

    # need these in case your view constructs any links or references any helper methods.
    av.class_eval do
      include Rails.application.routes.url_helpers
      include ApplicationHelper
    end

    pdf_html = av.render :template => "orders/show.pdf.erb", :layout => 'layouts/print.html.erb', :locals => {:order => order}

    # use wicked_pdf gem to create PDF from the doc HTML
    doc_pdf = WickedPdf.new.pdf_from_string(pdf_html)

    # save PDF to disk
    pdf_path = Rails.root.join('tmp', "#{order.id}.pdf")
    File.open(pdf_path, 'wb') do |file|
      file << doc_pdf
    end

  end

  private

  # get the Order object when the job is run
  def order
    @order = Order.find(order_id)
  end
end
