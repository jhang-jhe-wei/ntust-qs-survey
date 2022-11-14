namespace :one_time do
  desc <<-STRING
    1. 將國際處調整為最高權限
    2. 刪除所有測試帳號(Email 為 test 開頭)
    3. 刪除所有推薦人資料
  STRING
  task patch_v1: :environment do
    NtustDepartment.find_by(name: '國際處').update!(role: 'admin')
    User.where('email LIKE ?', '%test%').destroy_all
    Recommender.all.destroy_all
  end
end
