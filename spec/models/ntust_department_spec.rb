require 'rails_helper'

RSpec.describe NtustDepartment, type: :model do
  describe '#self_or_departments' do
    context 'When department is 營建工程系 which role is department' do
      let (:department) { NtustDepartment.find_by(name: '營建工程系') }
      it 'expects to get itself' do
        expect(department.self_or_departments).to contain_exactly(department)
      end
    end

    context 'When department is 電資學院 which role is college' do
      let (:department) { NtustDepartment.find_by(name: '電資學院') }
      it 'expects to get themselve and departments which belong to them' do
        expect(department.self_or_departments).to contain_exactly(
          NtustDepartment.find_by(name: '電子工程系'),
          NtustDepartment.find_by(name: '電機工程系'),
          NtustDepartment.find_by(name: '資訊工程系'),
          NtustDepartment.find_by(name: '光電工程研究所'),
          NtustDepartment.find_by(name: '電資學院')
        )
      end
    end

    context 'When department is 校務研究與發展中心 which role is admin' do
      let (:department) { NtustDepartment.find_by(name: '校務研究與發展中心') }
      it 'expects to get all departments' do
        expect(department.self_or_departments).to match_array(
          NtustDepartment.all.to_a
        )
      end
    end
  end
end
