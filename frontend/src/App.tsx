import './App.css';
import { Link, FetchError } from './types';
import type { MenuProps } from 'antd';
import { Button, Input, Layout, List, InputProps, ButtonProps } from 'antd';
import React, { useEffect, useState } from 'react';
import { loadLinks, submitLink } from './api';
const { Header, Content, Footer, Sider } = Layout;


function App() {
  const [inputURL, setInputURL] = useState('');
  const [inputTitle, setInputTitle] = useState('');
  const [links, setLinks] = useState<Link[]>([]);
  const [inputTitleError, setInputTitleError] = useState('');
  const [inputURLError, setInputURLError] = useState<string | null>(null);
  const [loadError, setLoadError] = useState<string | null>(null);

  useEffect(() => {
    setup();
  }, [])

  const setup = async () => {
    try {
      const links = await loadLinks();
      setLinks(links);
    } catch (error) {
      const fetchError = error as FetchError;
      setLoadError(fetchError.message);
    }
  };

  const handleInputURLChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInputURL(e.target.value);
  };
  const handleInputTitleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setInputTitle(e.target.value);
  };
  const deleteLinkClicked = async (id: string) => {
    try {

      console.log(`Deleting link with id ${id} succeeded`);
      await loadLinks();
    } catch (error) {
      const fetchError = error as FetchError;
      setLoadError(fetchError.message);
      console.error('Network call error:', error);
    }
  }

  const submitLinkClicked = async (e: React.MouseEvent<HTMLElement, MouseEvent>) => {
    if (inputTitle === '') {
      setInputTitleError('Title cannot be empty');
      return;
    }
    else if (inputURL === '') {
      setInputURLError('URL cannot be empty');
      return;
    }
    try {
      await submitLink(inputURL, inputTitle);
    } catch (error) {
      const fetchError = error as FetchError;
      setLoadError(fetchError.message);
      console.error('Error submitting link:', error);
    }
  }

  const getURLProps = (): InputProps => (
    {
      size: "large",
      placeholder: "Enter Link",
      status: inputURLError ? 'error' : '',
      value: inputURL,
      onChange: handleInputURLChange
    }
  );

  const getTitleProps = (): InputProps => (
    {
      size: "large",
      placeholder: "Enter Title",
      status: inputTitleError ? 'error' : '',
      value: inputTitle,
      onChange: handleInputTitleChange
    }
  );

  const getSubmitButtonProps = (): ButtonProps => (
    {
      type: "primary",
      disabled: (inputTitle === '' || inputURL === ''),
      onClick: submitLinkClicked
    }
  );

  return (
    <div className="App">
      <Layout>
        <Header>Oh, sick!</Header>
        <Content>
          <Input {...getURLProps()} />
          <Input {...getTitleProps()} />
          <Button {...getSubmitButtonProps()}>Submit</Button>
          <List<Link>
            header={<div>Header</div>}
            footer={<div>Footer</div>}
            bordered
            dataSource={links}
            renderItem={(link) => (
              <List.Item key={link.id} actions={[<Button danger={true} type="primary" onClick={(_: React.MouseEvent<HTMLElement, MouseEvent>) => deleteLinkClicked(link.id)}>Delete</Button>]}>
                {link.title}: <a href={link.url}>link</a>
              </List.Item>
            )}
          />
        </Content>
      </Layout>
    </div>
  );
}

export default App;
