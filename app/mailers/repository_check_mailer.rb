# frozen_string_literal: true

class RepositoryCheckMailer < ApplicationMailer
  def check_failed
    @check = params[:check]
    mail(to: @check.repository.user.email, subject: t('repository_check_mailer.check_failed.subject'))
  end

  def check_error
    @check, @error = params.pluck[:check, :error]
    mail(to: @check.repository.user.email, subject: t('repository_check_mailer.check_error.subject'))
  end
end
