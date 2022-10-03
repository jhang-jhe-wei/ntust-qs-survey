const map = {
  committed_on: '提報時間',
  exported_on: '曾匯出於',
  provider_unit: '提報單位',
  provider_name: '提供此名單之教師姓名',
  provider_email: '提供此名單之教師電郵',
  title: '稱謂',
  first_name: '名字',
  last_name: '姓',
  job_title: '職稱',
  department: '部門',
  email: '電子信箱',
  institution_name: '機構名稱',
  location: '所屬國家',
  industry_name: '產業類別',
  company_name: '公司名稱',
  academic: '學術界',
  industry: '產業界'
};

export type TranslateMapKey = keyof typeof map;

function Translate(txt: TranslateMapKey) {
  return map[txt];
}

export default Translate;
