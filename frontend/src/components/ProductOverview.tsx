import React from 'react';
import { Layers, Bot, GitMerge, Shield, ArrowUpRight, Database } from 'lucide-react';

export const ProductOverview: React.FC = () => {
  const highlights = [
    {
      icon: <Layers className="w-6 h-6 text-brand-400" />,
      title: 'Modularidade',
      description: 'Habilite e configure somente os recursos que sua empresa necessita em cada etapa.'
    },
    {
      icon: <Bot className="w-6 h-6 text-indigo-400" />,
      title: 'Inteligência Artificial',
      description: 'Arquitetura preparada para agentes especializados e orquestração inteligente de conversas.'
    },
    {
      icon: <GitMerge className="w-6 h-6 text-emerald-400" />,
      title: 'Automação & Integrações',
      description: 'Conexão fluida entre WhatsApp, n8n, webhooks e sistemas corporativos.'
    },
    {
      icon: <Shield className="w-6 h-6 text-purple-400" />,
      title: 'Isolamento Multi-Tenant',
      description: 'Garantia absoluta de separação de dados por tenant em todas as camadas da aplicação.'
    },
    {
      icon: <Database className="w-6 h-6 text-cyan-400" />,
      title: 'PostgreSQL Enterprise',
      description: 'Banco relacional com UUIDs v4, JSONB, auditoria imutável e validação por triggers.'
    },
    {
      icon: <ArrowUpRight className="w-6 h-6 text-amber-400" />,
      title: 'Evolução Contínua',
      description: 'Plataforma em constante expansão através da incorporação de novos módulos.'
    }
  ];

  return (
    <section id="soluctions" className="py-20 bg-dark-base relative overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Section Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Plataforma SaaS Modular
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Conheça o <span className="gradient-text">SDTech Solutions</span>
          </h2>

          <p className="text-base sm:text-lg text-slate-300 leading-relaxed">
            Uma plataforma SaaS modular criada para acompanhar a evolução da sua empresa. Ative novos recursos e módulos sob medida conforme suas metas operacionais crescem.
          </p>
        </div>

        {/* Highlights Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {highlights.map((item, index) => (
            <div key={index} className="glass-card p-6 rounded-2xl space-y-4 border border-slate-800 hover:border-brand-500/40 transition-all duration-300 group">
              <div className="w-12 h-12 rounded-xl bg-slate-800/80 flex items-center justify-center border border-slate-700 group-hover:scale-110 transition-transform">
                {item.icon}
              </div>
              <h3 className="text-xl font-bold text-white group-hover:text-brand-300 transition-colors">
                {item.title}
              </h3>
              <p className="text-sm text-slate-400 leading-relaxed">
                {item.description}
              </p>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
};
