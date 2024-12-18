import { useState } from "react";
import { NavLink } from "react-router";
import InscriptionView from "../components/inscription/View";
import InscriptionForm from "../components/inscription/Form";
import InscriptionStatus from "../components/inscription/Status";

function Home() {
  const latestInscriptions = [
    {
      id: 1,
      content: "Hello, World!",
      type: "text"
    },
    {
      id: 2,
      content: "https://gssc.esa.int/navipedia/images/a/a9/Example.jpg",
      type: "image"
    },
    {
      id: 3,
      content: "https://i.gifer.com/fetch/w300-preview/4b/4b8e74df2974d2ec97065e78b3551841.gif",
      type: "image"
    },
    {
      id: 4,
      content: "Hello, World 2!\nThis is a multiline text.\mThis text is long.\nAnd another line\nAnd another longer line\n...\nHello\nWorld\nLorum\nIpsum\nText\n...\nMore\nLines",
      type: "text"
    },
    {
      id: 5,
      content: "https://gssc.esa.int/navipedia/images/a/a9/Example.jpg",
      type: "image"
    },
    {
      id: 6,
      content: "Hello, World 3!\nThis is a multiline text.\nThis is a multiline text 2.",
      type: "text"
    },
    {
      id: 7,
      content: "https://gssc.esa.int/navipedia/images/a/a9/Example.jpg",
      type: "image"
    },
    {
      id: 8,
      content: "Hello, World 4!",
      type: "text"
    },
    {
      id: 9,
      content: "https://gssc.esa.int/navipedia/images/a/a9/Example.jpg",
      type: "image"
    },
    {
      id: 10,
      content: "Hello, World 5!",
      type: "text"
    },
    {
      id: 11,
      content: "https://gssc.esa.int/navipedia/images/a/a9/Example.jpg",
      type: "image"
    },
    {
      id: 12,
      content: "Hello, World 6!",
      type: "text"
    },
  ];

  const [isInscribing, setIsInscribing] = useState(false);
  return (
    <div className="w-full flex flex-col h-max">
      <div className="bg__color--tertiary w-full flex flex-col items-center justify-center py-8">
        <h1 className="text-4xl font-bold">Inscribe on Bitcoin</h1>
        <h2 className="text-lg mb-8">Starknet's Decentralized Inscriptor Network</h2>
        <InscriptionForm isInscribing={isInscribing} setIsInscribing={setIsInscribing} />
        {isInscribing && <InscriptionStatus />}
      </div>
      <div className="w-full flex flex-col items-center py-2 bg__color--primary h-full border-t-2 border-[var(--color-primary-light)]">
        <div className="w-full flex flex-row items-center justify-between">
          <h1 className="text-xl font-bold px-4">Recent Inscriptions</h1>
          <NavLink to="/inscriptions" className="flex flex-row items-center">
            <p className="text-sm font-bold px-4 tab__nav">Explore &rarr;</p>
          </NavLink>
        </div>
        <div className="w-full grid grid-cols-4 gap-4 px-4 py-8">
          {latestInscriptions.map((inscription) => (
            <InscriptionView key={inscription.id} inscription={inscription} />
          ))}
        </div>
        <button className="button--gradient button__primary w-fit mb-4">Load More...</button>
      </div>
    </div>
  );
}

export default Home;
