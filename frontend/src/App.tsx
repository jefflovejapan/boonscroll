import React, { useState } from 'react';
import logo from './logo.svg';
import './App.css';
import { Button, Layout, Input, List, Typography } from 'antd';
import type { MenuProps } from 'antd';
const { Header, Content, Footer, Sider } = Layout;


function App() {
  const [inputValue, setInputValue] = useState('');
  const handleButtonClick = () => {
    console.log('Button clicked!');
    alert('Button clicked!');
  };
  const submitLinkClick = async () => {
    if (inputValue) {
      try {
        const response = await fetch('http://127.0.0.1:8080/links', {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ url: inputValue, title: "cool video" }),
        });
        const result = await response.json();
        console.log('Network call result:', result);
        alert('Network call successful!');
      } catch (error) {
        console.error('Network call error:', error);
        alert('Network call failed!');
      }
    } else {
      alert('Input is empty!');
    }
  };
  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInputValue(e.target.value);
  };

  type MenuItem = Required<MenuProps>['items'][number];
  const data: String[] = [
    "dog",
    "cat",
    "bird"
  ];


  return (
    <div className="App">
      <Layout>
        <Header>Oh, sick!</Header>
        <Content>
          <Input size="large" placeholder="Enter Link" value={inputValue} onChange={handleInputChange} />
          <Button type="primary" onClick={submitLinkClick}>Submit</Button>
          <List
            header={<div>Header</div>}
            footer={<div>Footer</div>}
            bordered
            dataSource={data}
            renderItem={(item) => (
              <List.Item>
                {item}
              </List.Item>
            )}
          />

        </Content>
      </Layout>
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.tsx</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>
        <div>
          <Button type="primary" onClick={handleButtonClick}>Yo God!</Button>
        </div>
      </header>
    </div>
  );
}

export default App;
