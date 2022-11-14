# frozen_string_literal: true

# Add all departments in NTUST to database.
college = NtustDepartment.find_or_create_by(name: '工程學院', role: 'college')
college.departments.find_or_create_by(name: '自動化與控制研究所')
college.departments.find_or_create_by(name: '機械工程系')
college.departments.find_or_create_by(name: '材料科學與工程系')
college.departments.find_or_create_by(name: '營建工程系')
college.departments.find_or_create_by(name: '化學工程系')
college.departments.find_or_create_by(name: '先進科技全英語學士學位學程')
college.departments.find_or_create_by(name: '全球發展工程學士學位學程')
college.departments.find_or_create_by(name: '高階科技研發碩士學位學程 (EMRD在職專班)')

college = NtustDepartment.find_or_create_by(name: '電資學院', role: 'college')
college.departments.find_or_create_by(name: '電子工程系')
college.departments.find_or_create_by(name: '光電工程研究所')
college.departments.find_or_create_by(name: '電機工程系')
college.departments.find_or_create_by(name: '資訊工程系')

college = NtustDepartment.find_or_create_by(name: '管理學院', role: 'college')
college.departments.find_or_create_by(name: '管理研究所')
college.departments.find_or_create_by(name: '工業管理系')
college.departments.find_or_create_by(name: '企業管理系')
college.departments.find_or_create_by(name: '財務金融研究所')
college.departments.find_or_create_by(name: '資訊管理系')
college.departments.find_or_create_by(name: '科技管理研究所')
college.departments.find_or_create_by(name: '管理學院MBA')
college.departments.find_or_create_by(name: 'EMBA碩士在職專班')
college.departments.find_or_create_by(name: '管理學士班')

college = NtustDepartment.find_or_create_by(name: '設計學院', role: 'college')
college.departments.find_or_create_by(name: '設計系')
college.departments.find_or_create_by(name: '建築系')

college = NtustDepartment.find_or_create_by(name: '人文社會學院', role: 'college')
college.departments.find_or_create_by(name: '數位學習與教育研究所')
college.departments.find_or_create_by(name: '應用外語系')
college.departments.find_or_create_by(name: '人文社會學科')
college.departments.find_or_create_by(name: '師資培育中心')

college = NtustDepartment.find_or_create_by(name: '應用科技學院', role: 'college')
college.departments.find_or_create_by(name: '應用科技研究所')
college.departments.find_or_create_by(name: '醫學工程研究所')
college.departments.find_or_create_by(name: '專利研究所')
college.departments.find_or_create_by(name: '色彩與照明科技研究所')
college.departments.find_or_create_by(name: '應用科技學士學位學程')

college = NtustDepartment.find_or_create_by(name: '產業創新學院', role: 'college')
college.departments.find_or_create_by(name: '智慧製造科技研究所')
college.departments.find_or_create_by(name: '人工智慧跨域科技研究所')
college.departments.find_or_create_by(name: '能源永續科技研究所')

NtustDepartment.find_or_create_by(name: '學務處就輔組', role: 'department')
NtustDepartment.find_or_create_by(name: '秘書室校友組', role: 'department')
NtustDepartment.find_or_create_by(name: '產學處', role: 'department')

NtustDepartment.find_or_create_by(name: '國際處', role: 'admin')
NtustDepartment.find_or_create_by(name: '校務研究與發展中心', role: 'admin')
NtustDepartment.find_or_create_by(name: '校長', role: 'admin')
NtustDepartment.find_or_create_by(name: '副校長', role: 'admin')
