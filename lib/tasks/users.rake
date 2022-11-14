# frozen_string_literal: true

namespace :users do
  desc '依照傳入的單位、帳號和密碼建立使用者'
  task :create, %i[department_name email password] => :environment do |_task, args|
    department = NtustDepartment.find_by(name: args.department_name)
    department.users.create!(
      name: args.department_name,
      email: args.email,
      password: args.password
    )
  end

  desc '變更使用者的所屬單位'
  task :update_department, %i[email department_name] => :environment do |_task, args|
    User.find_by(email: args.email).update!(department: NtustDepartment.find_by(name: args.department_name))
  end
end
