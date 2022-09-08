import React, { useState, useEffect } from 'react';
import { mountToWindow } from '../helpers/helper';

const CategorySelector = ({ value }) => {
  const [state, setState] = useState(value);

  useEffect(()=>{
    const academicTargets = document.querySelectorAll('.academic')
    const industryTargets = document.querySelectorAll('.industry')
    academicTargets.forEach((target:HTMLElement) => target.style.display = 'none');
    industryTargets.forEach((target:HTMLElement) => target.style.display = 'none');

    if(state == '學術界'){
      academicTargets.forEach((target:HTMLElement) => target.style.display = '');
    }else{
      industryTargets.forEach((target:HTMLElement) => target.style.display = '');
    }
  }, [state])

  return (
    <>
      <label
        className="recommender-form-label"
        htmlFor="recommender_category"
      >
        名單種類
      </label>
      <select
        className="recommender-form-select"
        name="recommender[category]"
        id="recommender_category"
        onChange={(e)=>{setState(e.target.value)}}
        value={state}
      >
        <option value="學術界">學術界</option>
        <option value="產業界">產業界</option>
      </select>
    </>
  );
}

mountToWindow(CategorySelector, 'CategorySelector');
