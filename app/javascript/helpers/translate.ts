const map = {
  title: 'Title',
  first_name: 'First Name',
  last_name: 'Last Name',
  job_title: 'Job Title',
  department: 'Department',
  email: 'Email',
  institution_name: 'Institution',
  country_name: 'Location'
};

export type TranslateMapKey = keyof typeof map;

function Translate(txt: TranslateMapKey) {
  return map[txt];
}

export default Translate;
