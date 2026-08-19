import React from 'react';
import { Bot, Workflow, MessageSquare, Webhook, Layers, ShieldCheck } from 'lucide-react';

export const Features: React.FC = () => {
  const features = [
    {
      icon: <Bot className="w-8 h-8 text-brand-400" />,
      title: 'Inteligência Artificial',
      desc: 'Agentes especializados (Supervisor IA e Recepcionista IA) para conduzir diálogos contextuais e orquestrar triagens.'
    },
    {
      icon: <Workflow className="w-8 h-8 text-indigo-400" />,
      title: 'Automação',
      desc: 'Automatização de fluxos operacionais, respostas frequentes e tarefas repetitivas integradas ao n8n.'
    },
    {
      icon: <MessageSquare className="w-8 h-8 text-emerald-400" />,
      title: 'Atendimento',
      desc: 'Estrutura preparada para atendimento inteligente e gestão centralizada de conversas do WhatsApp.'
    },
    {
      icon: <Webhook className="w-8 h-8 text-purple-400" />,
      title: 'Integrações',
      desc: 'Conexão robusta via APIs REST, Webhooks e suporte a sistemas corporativos de terceiros.'
    },
    {
      icon: <Layers className="w-8 h-8 text-cyan-400" />,
      title: 'Arquitetura Modular',
      desc: 'Habilite e pague somente pelos módulos contratados. Expansão sem refatoração do Core.'
    },
    {
      icon: <ShieldCheck className="w-8 h-8 text-amber-400" />,
      title: 'Multi-Tenant',
      desc: 'Isolamento lógico absoluto por tenant em nível de banco de dados, API, n8n e agentes de IA.'
    }
  ];

  return (
    <section id="recursos" className="py-20 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Recursos da Plataforma
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Tecnologia de ponta a ponta
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            Recursos projetados para proporcionar máxima performance, segurança e flexibilidade operacional.
          </p>
        </div>

        {/* Features Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          {features.map((feature, idx) => (
            <div key={idx} className="glass-card p-8 rounded-2xl border border-slate-800 hover:border-brand-500/50 transition-all duration-300 space-y-4 group">
              <div className="w-14 h-14 rounded-2xl bg-slate-800/90 flex items-center justify-center border border-slate-700 group-hover:scale-110 transition-transform">
                {feature.icon}
              </div>

              <h3 className="text-xl font-bold text-white group-hover:text-brand-300 transition-colors">
                {feature.title}
              </h3>

              <p className="text-sm text-slate-400 leading-relaxed">
                {feature.desc}
              </p>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
};
