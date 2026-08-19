import React from 'react';
import { Navbar } from './components/Navbar';
import { Hero } from './components/Hero';
import { AboutSDTech } from './components/AboutSDTech';
import { ProductOverview } from './components/ProductOverview';
import { ModularArchitecture } from './components/ModularArchitecture';
import { Features } from './components/Features';
import { AgentArchitecture } from './components/AgentArchitecture';
import { SupportAI } from './components/SupportAI';
import { Channels } from './components/Channels';
import { Integrations } from './components/Integrations';
import { SecurityGovernance } from './components/SecurityGovernance';
import { Evolution } from './components/Evolution';
import { Roadmap } from './components/Roadmap';
import { Differentials } from './components/Differentials';
import { HowItWorks } from './components/HowItWorks';
import { ContactForm } from './components/ContactForm';
import { CTA } from './components/CTA';
import { Footer } from './components/Footer';

export const App: React.FC = () => {
  return (
    <div className="min-h-screen bg-dark-base text-slate-100 selection:bg-brand-500 selection:text-white">
      <Navbar />
      <main>
        <Hero />
        <AboutSDTech />
        <ProductOverview />
        <ModularArchitecture />
        <Features />
        <AgentArchitecture />
        <SupportAI />
        <Channels />
        <Integrations />
        <SecurityGovernance />
        <Evolution />
        <Roadmap />
        <Differentials />
        <HowItWorks />
        <ContactForm />
        <CTA />
      </main>
      <Footer />
    </div>
  );
};

export default App;
