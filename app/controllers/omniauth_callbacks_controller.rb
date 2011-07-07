class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  # FIXME: A straight copy from the Devise example.
  # TODO: Q: What re the devise provided methods and events?  How to use them?
  def github
    @user = User.find_for_github_oauth(env['omniauth.auth'], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t('devise.omniauth_callbacks.success', :kind => 'GitHub')
      sign_in_and_redirect @user, :event => :authentication
    else
      session['devise.github_data'] = env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

end
