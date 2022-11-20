class TransactionsController < ApplicationController
  before_action :set_business
  before_action :set_transaction, only: %i[ show receipt ]

  def index
    @transactions = Transaction.where(business_id: @business.id)
  end

  def new
    @transaction = @business.transactions.new
    @transaction.amount = Business::TAXES[@business.business_type]
  end

  def create
    @transaction = @business.transactions.new(transaction_params)
    #@transaction.transaction_type = :debit

    respond_to do |format|
      begin
        @transaction.status = :success
        @transaction.message = 'Transaction was successful'
        @transaction.from_year = DateTime.now.year
        @transaction.to_year = DateTime.now.year
        @transaction.save!
        format.html { redirect_to business_transactions_url(@business), notice: "Payment was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      rescue ActiveRecord::RecordInvalid => e
        logger.error(e.message)
        format.html { render :new, status: :unprocessable_entity, alert: "Something went wrong" }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  def receipt
    Prawn::Document.generate("#{Rails.root.join(*%w(public/receipts))}/#{@transaction.reference_number}.pdf") do |pdf|
      image = "#{Rails.root.join(*%w(app assets))}/images/logo.png"
      #[{:image => image}, 'VILLAGE PANCHAYAT - CHERKI']

      pdf.image image, :width => 60, :at => [10, pdf.bounds.height - 20], :align => :left, position: :left
      pdf.draw_text "VILLAGE PANCHAYAT - CHERKI", size: 12, style: :bold, :at => [190, pdf.bounds.height - 40]
      pdf.draw_text "REGISTRATION & TAX RECEIPT", size: 10, style: :bold, :at => [210, pdf.bounds.height - 60]
      pdf.draw_text "BLOCK SHERGHATI, DISTRICT GAYA-BIHAR 824237", size: 10, style: :bold, :at => [160, pdf.bounds.height - 80]
      pdf.draw_text "Email: info.cherkipanchayat@gmail.com", size: 9, style: :bold, :at => [200, pdf.bounds.height - 95]
      pdf.draw_text "Phone: 06326242097", size: 9, style: :bold, :at => [240, pdf.bounds.height - 108]

      pdf.move_down 180

      data = [
        ["Receipt No.:", @transaction.reference_number],
        ["Business Name: ", @transaction.business.name],
        ["Owner Name: ", @transaction.business.owner_name],
        ["Father / Husband Name:", @transaction.business.father_name],
        ["Mobile Number:",  @transaction.business.mobile],
        ["Address", @transaction.business.address],
        ["Type of Establishment:", @transaction.business.business_type.humanize],
        ["Transaction Type", @transaction.transaction_type.humanize],
        ["Receipt Date:", @transaction.created_at.strftime("%-d/%-m/%y: %H:%M")],
        ["Tax Paid Upto:", "#{@transaction.from_year} - #{@transaction.to_year}"],
        ["Amount", @transaction.amount]
      ]

      pdf.table data, :position => :center, :width => pdf.bounds.width - 100



      pdf.move_down 10

      pdf.indent(50, 50) do # left and right padding
        pdf.text "Approved by: ", size: 12, align: :left
        pdf.text "Stamp: ", size: 12, align: :right
      end

      pdf.draw_text "This is a computer generated receipt, please contact Cherki Panchayat for any discrepancy.", size: 8, :at => [100, 10]
    end
    #render :pdf => "#{Rails.root.join(*%w(public/receipts))}/#{@transaction.reference_number}.pdf", :disposition => :inline

    send_file(
      "#{Rails.root.join(*%w(public/receipts))}/#{@transaction.reference_number}.pdf",
      filename: "#{@transaction.reference_number}.pdf",
      type: "application/pdf"
    )
  end

  private

  def set_business
    @business = Business.find(params[:business_id])
  end

  def set_transaction
    @transaction = Transaction.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def transaction_params
    params.require(:transaction).permit(:amount, :business_id)
  end
end
