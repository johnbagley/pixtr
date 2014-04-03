class ChargesController < ApplicationController

  def new
  end

  def create
    # Amount in cents
    @amount = 500

    customer = Stripe::Customer.create(
      :email => 'example@stripe.com',
      :card  => params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      :customer    => customer.id,
      :amount      => @amount,
      :description => 'Rails Stripe customer',
      :currency    => 'usd'
    )
    current_user.upgrade
    flash[:upgraded] = "You've been upgraded."
    redirect_to profile_path
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end
end