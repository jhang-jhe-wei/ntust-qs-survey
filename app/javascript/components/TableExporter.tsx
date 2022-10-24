import React, { useState, useEffect } from 'react';
import { mountToWindow } from '../helpers/helper';
import Translate from '../helpers/translate';
import Button from '@mui/material/Button';
import axios from 'axios';
import FileDownload from 'js-file-download';

type Recommender = {
  id: number;
  title: string;
  firstName: string;
  lastName: string;
  jobTitle: string;
  department: string;
  institution: string;
  location: string;
  email: string;
  Phone: string;
  exported_on: string;
}

type TableExporterProps = {
  columns: string[];
  data: Recommender[];
  category: "academic" | "industry";
}

const TableExporter = (props: TableExporterProps) => {

  const { columns, data, category } = props;
  const [allSelect, setAllSelect] = useState<boolean>(false);
  const [recommenders, setRecommenders] = useState<Recommender[]>(data);
  const [ids, setIds] = useState<number[]>([]);

  useEffect(()=>{
    if(allSelect){
      setIds(recommenders.map(recommender => recommender.id))
    }else{
      setIds([])
    }
  }, [allSelect])

  const checkHandler = (id: number): void => {
    const index = ids.findIndex(ele => ele == id);
    if(index >= 0) {
      setIds(ids =>  [
        ...ids.slice(0, index),
        ...ids.slice(index+1)
      ])
    }else{
      setIds(ids => {
        return [...ids, id]
      })
    }
  }
  const allSelectHandler = (): void => {
    setAllSelect(state => !state)
  }

  const downloadHandler = async () => {

    await axios.post(
      '/admin/recommenders/export',
      {
        ids: ids,
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
        recommenders.map((recommender) => { if(ids.find(id => id == recommender.id)){
          recommender.exported_on = filename.match(/\d{4}-\d{2}-\d{2}/)[0]
        }
          return recommender;

        })
      ));
      setIds([]);
    }).catch(function (error) {
        // handle error
        console.log(error);
      })
  }

  const sortRecommenders = (column: string) => {
    setRecommenders(recommenders => [
      ...recommenders.sort((a, b) => {
        if(a[column] > b[column]) return 1;
        if(a[column] < b[column]) return -1;
        return 0;
      })
    ])
  }

  return (
    <React.Fragment>
      <p className="mb-2 text-lg">
        { `${Translate(category)}名單，共計 `  }
        <span className="text-red-700">
          { recommenders.length }
        </span> 筆
        <span className="text-sm text-red-700">(點選「欄位標題」可將資料依序排列)</span>
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
                <th
                  key={column}
                  scope="col"
                  className="recommender-table-th"
                  onClick={ () => sortRecommenders(column) }
                >
                  { Translate(column) }
                </th>
              ))
            }
          </tr>
        </thead>
        <tbody>
          {
            recommenders.map((recommender) =>(
              <tr key={recommender.id} className="border-b odd:bg-white even:bg-gray-50" >
                <td key={recommender.id} className="recommender-table-td">
                  <input
                    type="checkbox"
                    onChange={ () => checkHandler(recommender.id) }
                    checked={ !!ids.find(id => id == recommender.id) }
                  />
                </td>
              {
                columns.map(column => (
                  <td key={column} className="recommender-table-td">
                    {recommender[column]}
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

