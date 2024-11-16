import Image from "next/image";
import '../index.css';
import Ticket from "./ticket";
export default function Home() {
  return (
    
    <div>
      <h1 className="bg-blue-500 text-white p-4">
      Hello world!
      </h1>
      <Ticket></Ticket>
    </div>
  );
}
