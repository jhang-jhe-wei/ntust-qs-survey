import React, { useState, useEffect } from 'react';
import Autocomplete from '@mui/material/Autocomplete';
import { mountToWindow } from '../helpers/helper';
import axios from 'axios';

const CompanyAutocomplete = () => {
  const [options, setOptions] = useState([]);
  useEffect(()=>{
    const fetchOptions = async () =>{
      await axios.get('/institutions')
        .then(function (response) {
          setOptions(response.data);
        })
        .catch(function (error) {
          // handle error
          console.log(error);
        })
    }
    fetchOptions();
  }, [])

  return (
    <Autocomplete
      sx={{
        display: 'block'
      }}
      freeSolo
      options={options}
      renderInput={(params) => (
        <div ref={params.InputProps.ref}>
          <input
            type="text"
            name="company"
            placeholder="Company Name"
            {...params.inputProps}
            className="recommender-form-input"
            pattern='[A-Za-z0-9. ,_-]*'
            title='限以英文 (半形) 填入，並勿填寫如É、Ÿ等特殊字元。'
          />
        </div>
      )}
    />
    );
}

mountToWindow(CompanyAutocomplete, 'CompanyAutocomplete');

