import React from 'react';
import { Compass, FileText, CheckSquare, Wrench } from 'lucide-react';

export const HowItWorks: React.FC = () => {
  const steps = [
    {
      num: '01',
      icon: <Compass className="w-6 h-6 text-brand-400" />,
      title: 'Conheça',
      desc: 'Explore as capacidades do SDTech Soluctions e converse com a equipe SDTECH.'
    },
    {
      num: '02',
      icon: <FileText className="w-6 h-6 text-indigo-400" />,
      title: 'Defina suas necessidades',
      desc: 'Mapeie seus canais, processos de atendimento e metas operacionais.'
    },
    {
      num: '03',
      icon: <CheckSquare className="w-6 h-6 text-emerald-400" />,
      title: 'Escolha os módulos',
      desc: 'Selecione sob medida os módulos previstos para o contrato da sua empresa.'
    },
    {
      num: '04',
      icon: <Wrench className="w-6 h-6 text-purple-400" />,
      title: 'A SDTECH configura sua plataforma',
      desc: 'Nossa equipe ativa o ambiente multi-tenant isolado e realiza os testes.'
    }
  ];

  return (
    <section className="py-20 bg-dark-surface/40 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Jornada de Implantação
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Como Funciona
          </h2>

          <p className="text-base sm:text-lg text-brand-300 font-semibold">
            "Cada ambiente é configurado conforme os módulos previstos no contrato."
          </p>
        </div>

        {/* 4 Steps Grid */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {steps.map((step, idx) => (
            <div key={idx} className="glass-card p-6 rounded-2xl border border-slate-800 space-y-4 relative group hover:border-brand-500/40 transition-all">
              <div className="flex items-center justify-between">
                <span className="text-3xl font-black text-slate-600 group-hover:text-brand-400 transition-colors">{step.num}</span>
                <div className="w-12 h-12 rounded-xl bg-slate-800/80 flex items-center justify-center border border-slate-700">
                  {step.icon}
                </div>
              </div>

              <h3 className="text-lg font-bold text-white group-hover:text-brand-300 transition-colors">
                {step.title}
              </h3>

              <p className="text-xs text-slate-400 leading-relaxed">
                {step.desc}
              </p>
            </div>
          ))}
        </div>

      </div>
    </section>
  );
};
