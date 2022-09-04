import React, { useState, useEffect } from 'react';
import { mountToWindow } from '../helpers/helper';
import Translate from '../helpers/translate';

type Recommender = {
  id: Number;
  source: String;
  title: String;
  firstName: String;
  lastName: String;
  jobTitle: String;
  department: String;
  institution: String;
  location: String;
  email: String;
  Phone: String;
}

type TableExporterProps = {
  columns: String[];
  recommenders: Recommender[];
}

const TableExporter = (props: TableExporterProps) => {

  const { columns, recommenders } = props;

  return (
    <>
      <table className="w-full text-sm text-left text-gray-500">
        <thead>
          <tr>
            {
              columns.map(column => (
                <th scope="col" className="recommender-table-th">
                  { Translate(column.toString()) }
                </th>
              ))
            }
          </tr>
        </thead>
        <tbody>
          {
            recommenders.map(recommender =>(

            <tr key={recommender.id.toString()} className="border-b odd:bg-white even:bg-gray-50" >
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
    </>
  );
}

mountToWindow(TableExporter, 'TableExporter');

