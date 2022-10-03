import React, { useState, useEffect } from 'react';
import { mountToWindow } from '../helpers/helper';
import Translate from '../helpers/translate';
import Button from '@mui/material/Button';
import axios from 'axios';
import FileDownload from 'js-file-download';

type Recommender = {
  id: Number;
  title: String;
  firstName: String;
  lastName: String;
  jobTitle: String;
  department: String;
  institution: String;
  location: String;
  email: String;
  Phone: String;
  exported_on: string;
}

type TableExporterProps = {
  columns: String[];
  data: Recommender[];
  category: "academic" | "industry";
}

const TableExporter = (props: TableExporterProps) => {

  const { columns, data, category } = props;
  const [allSelect, setAllSelect] = useState<boolean>(false);
  const [recommenders, setRecommenders] = useState<Recommender[]>(data);
  const [checkeds, setCheckeds] = useState<boolean[]>(Array(recommenders.length).fill(false));

  useEffect(()=>{
    if(allSelect){
      setCheckeds(Array(recommenders.length).fill(true));
    }else{
      setCheckeds(Array(recommenders.length).fill(false));
    }
  }, [allSelect])

  const checkHandler = (index: number): void => {
    setCheckeds(checkeds => {
      return [
        ...checkeds.slice(0, index),
        !checkeds[index],
        ...checkeds.slice(index+1)
      ]
    })
  }

  const getIds = (): Number[] => (
    recommenders.filter((_, index) => ( checkeds[index] )).map(recommender=>(
      recommender.id
    ))
  )

  const allSelectHandler = (): void => {
    setAllSelect(state => !state)
  }

  const downloadHandler = async () => {

    await axios.post(
      '/admin/recommenders/export',
      {
        ids: getIds(),
        category: category,
        withCredentials: true
      },
      {
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        }
      }
    ).then(response=>{
      const filename = response.headers['content-disposition']
        .match(/.*filename="(?<filename>.*)".*/)[1];
      FileDownload(response.data, filename);
      setRecommenders(recommenders => (
        recommenders.map((recommender, index) => { if(checkeds[index]){
          recommender.exported_on = filename.match(/\d{4}-\d{2}-\d{2}/)[0]
        }
          return recommender;

        })
      ));
      setCheckeds([]);
    }).catch(function (error) {
        // handle error
        console.log(error);
      })
  }

  return (
    <React.Fragment>
      <p className="mb-2 text-lg">
        { `${Translate(category)}名單，共計 `  }
        <span className="text-red-700">
          { recommenders.length }
        </span> 筆
      </p>
    <div className="mb-5 overflow-x-auto shadow-md">
      <table className="w-full text-sm text-left text-gray-500">
        <thead>
          <tr>
            <th className="recommender-table-th">
              <input
                type="checkbox"
                onChange={allSelectHandler}
                checked={ allSelect }
              />
            </th>
            {
              columns.map(column => (
                <th key={column.toString()} scope="col" className="recommender-table-th">
                  { Translate(column) }
                </th>
              ))
            }
          </tr>
        </thead>
        <tbody>
          {
            recommenders.map((recommender, index) =>(
              <tr key={recommender.id.toString()} className="border-b odd:bg-white even:bg-gray-50" >
                <td key={recommender.id.toString()} className="recommender-table-td">
                  <input
                    type="checkbox"
                    onChange={ ()=>{ checkHandler(index) } }
                    checked={ checkeds[index] }
                  />
                </td>
              {
                columns.map(column => (
                  <td key={column.toString()} className="recommender-table-td">
                    {recommender[column.toString()]}
                  </td>
                ))
              }
            </tr>
          ))
          }
        </tbody>
        </table>
        <Button
          variant="contained"
          onClick={ downloadHandler }
          sx={ { mt: '12px', mb: '12px', ml: '12px' } }
        >
          下載選取的推薦人
        </Button>
    </div>
    </React.Fragment>
  );
}

mountToWindow(TableExporter, 'TableExporter');

