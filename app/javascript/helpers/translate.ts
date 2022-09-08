const map = {
  title: 'Title',
  first_name: 'First Name',
  last_name: 'Last Name',
  job_title: 'Job Title',
  position: 'Position',
  department: 'Department',
  email: 'Email',
  institution_name: 'Institution',
  location: 'Location',
  industry_name: 'Industry',
  company_name: 'Company Name',
  academic: '學術界',
  industry: '產業界'
};

export type TranslateMapKey = keyof typeof map;

function Translate(txt: TranslateMapKey) {
  return map[txt];
}

export default Translate;
