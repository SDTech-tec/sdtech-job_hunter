import React from 'react';
import { Layers, Bot, Share2, TrendingUp, ShieldCheck, Cpu } from 'lucide-react';

export const Differentials: React.FC = () => {
  const items = [
    {
      icon: <Layers className="w-6 h-6 text-brand-400" />,
      title: 'MODULAR',
      text: 'Utilize somente o que sua empresa precisa.'
    },
    {
      icon: <Bot className="w-6 h-6 text-indigo-400" />,
      title: 'INTELIGENTE',
      text: 'Arquitetura preparada para inteligência artificial.'
    },
    {
      icon: <Share2 className="w-6 h-6 text-emerald-400" />,
      title: 'INTEGRÁVEL',
      text: 'Conecte seus sistemas através de APIs e webhooks.'
    },
    {
      icon: <TrendingUp className="w-6 h-6 text-purple-400" />,
      title: 'ESCALÁVEL',
      text: 'Construído para evoluir junto com sua operação.'
    },
    {
      icon: <ShieldCheck className="w-6 h-6 text-cyan-400" />,
      title: 'MULTI-TENANT',
      text: 'Ambientes independentes para diferentes empresas.'
    },
    {
      icon: <Cpu className="w-6 h-6 text-amber-400" />,
      title: 'EVOLUTIVO',
      text: 'Novos módulos podem ampliar a plataforma.'
    }
  ];

  return (
    <section className="py-20 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Diferenciais Competitivos
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Por que escolher o SDTech Soluctions?
          </h2>
        </div>

        {/* 6 Differentials Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          {items.map((diff, idx) => (
            <div key={idx} className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3 hover:border-brand-500/40 transition-all">
              <div className="w-12 h-12 rounded-xl bg-slate-800/80 flex items-center justify-center border border-slate-700">
                {diff.icon}
              </div>

              <h3 className="text-lg font-extrabold text-white tracking-wider">
                {diff.title}
              </h3>

              <p className="text-sm text-slate-300">
                "{diff.text}"
              </p>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
};
