require 'spec_helper'

describe SubjectObserver do
  context "Logger" do
    it "logs the creation" do
      sub = Factory(:subject, :visible => true)
      Factory(:lecture, :subject => sub)

      ActiveRecord::Observer.with_observers(:subject_observer) do
        expect {
          sub.finalized = true
          sub.save
        }.should change(sub.logs, :count).by(1)
      end
    end
  end

  context "mailer" do
    before do
      UserNotifier.delivery_method = :test
      UserNotifier.perform_deliveries = true
      UserNotifier.deliveries = []
    end

    it "notifies creation" do
      sub = Factory(:subject, :visible => true)
      space = Factory(:space, :owner => sub.owner)
      Factory(:lecture, :subject => sub, :owner => sub.owner)
      sub.enroll(sub.owner)

      ActiveRecord::Observer.with_observers(:subject_observer) do
        expect {
          sub.finalized = true
          sub.save
        }.should change(UserNotifier.deliveries, :count).by(1)
      end
    end
  end
end