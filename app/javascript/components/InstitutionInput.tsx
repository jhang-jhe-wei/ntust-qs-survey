import React, {useState} from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import { mountToWindow } from '../helpers/helper';

type InstitutionInputProps = {
  value: Institution
  institutions: Institution[],
  countries: Country[]
}

type Institution = {
  name: string,
  country_id: number
}

type Country = {
  id: number,
  name: string
}

const InstitutionInput = (props: InstitutionInputProps) => {
  const {
    value,
    institutions,
    countries
  } = props

  const currentInstitution = {
    name: "",
    country_id: 1,
    ...value
  }

  const [countryId, setCountryId] = useState(currentInstitution.country_id)

  return (
    <React.Fragment>
      <label className="recommender-form-label" htmlFor="institution">Institution Name(機構名稱)</label>
      <Autocomplete
        sx={{
          display: 'block'
        }}
        freeSolo
        options={institutions}
        getOptionLabel={(option: Institution) => option.name }
        defaultValue={currentInstitution}
        onChange={(event, value: Institution) => {
          if( event.type === 'click' ){ setCountryId(value.country_id) }
        }}
        renderInput={(params) => (
          <div ref={params.InputProps.ref}>
            <input
              type="text"
              name="institution"
              placeholder="Institution Name"
              {...params.inputProps}
              className="recommender-form-input"
              pattern='[A-Za-z0-9. ,_-]*'
              title='限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。'
            />
          </div>
        )}
      />
      <label className="recommender-form-label" htmlFor="country">Country(所屬國家)</label>
      <select
        name="country"
        id="country"
        className="recommender-form-input"
        value={ countryId }
        onChange={ e => setCountryId(Number(e.target.value)) }
      >
        {
          countries.map(country =>
          <option key={country.id} value={country.id}>{country.name}</option>
          )
        }
      </select>
    </React.Fragment>
  );
}

mountToWindow(InstitutionInput, 'InstitutionInput');
