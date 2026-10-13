import React from 'react';
import { Building2, FileCheck2, Boxes, Settings2, MonitorCheck, ShieldAlert } from 'lucide-react';

export const ModularArchitecture: React.FC = () => {
  const steps = [
    {
      num: '01',
      icon: <Building2 className="w-6 h-6 text-brand-400" />,
      title: 'Empresa',
      subtitle: 'Sua Organização',
      desc: 'Sua empresa cadastra a operação no SDTech Solutions.'
    },
    {
      num: '02',
      icon: <FileCheck2 className="w-6 h-6 text-indigo-400" />,
      title: 'Contrato',
      subtitle: 'Plano Personalizado',
      desc: 'Definição dos módulos necessários para sua necessidade.'
    },
    {
      num: '03',
      icon: <Boxes className="w-6 h-6 text-emerald-400" />,
      title: 'Módulos Contratados',
      subtitle: 'Seleção Sob Medida',
      desc: 'Habilitação exclusiva dos recursos previstos em contrato.'
    },
    {
      num: '04',
      icon: <Settings2 className="w-6 h-6 text-purple-400" />,
      title: 'Configuração',
      subtitle: 'Gestão pela SDTECH',
      desc: 'O ADM Master SDTECH ativa e parametriza os módulos.'
    },
    {
      num: '05',
      icon: <MonitorCheck className="w-6 h-6 text-cyan-400" />,
      title: 'Ambiente do Cliente',
      subtitle: 'Operação Ativa',
      desc: 'Ambiente multi-tenant seguro e pronto para uso.'
    }
  ];

  return (
    <section className="py-20 bg-dark-surface/40 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Arquitetura Dinâmica
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Modelo de Habilitação Modular
          </h2>

          <p className="text-lg text-brand-300 font-semibold">
            "Você contrata o que precisa. A SDTECH configura o ambiente de acordo com o contrato."
          </p>

          <p className="text-base text-slate-400">
            Cada tenant possui um conjunto único de módulos ativados. O ADM Master da SDTECH controla e disponibiliza os recursos contratados de forma totalmente transparente e isolada.
          </p>
        </div>

        {/* Modular Pipeline Steps */}
        <div className="grid grid-cols-1 md:grid-cols-5 gap-4 relative">
          {steps.map((step, idx) => (
            <div key={idx} className="glass-card p-5 rounded-2xl border border-slate-800 hover:border-brand-500/40 transition-all flex flex-col justify-between space-y-4 relative group">
              <div>
                <div className="flex items-center justify-between mb-3">
                  <span className="text-2xl font-black text-slate-600 group-hover:text-brand-400 transition-colors">{step.num}</span>
                  <div className="w-10 h-10 rounded-xl bg-slate-800/80 flex items-center justify-center border border-slate-700">
                    {step.icon}
                  </div>
                </div>

                <h3 className="text-base font-bold text-white group-hover:text-brand-300 transition-colors">
                  {step.title}
                </h3>
                <span className="text-xs font-semibold text-brand-400 block mb-2">{step.subtitle}</span>

                <p className="text-xs text-slate-400 leading-relaxed">
                  {step.desc}
                </p>
              </div>
            </div>
          ))}
        </div>

        {/* Governance Notice */}
        <div className="mt-12 glass-card p-6 rounded-2xl border border-amber-500/30 bg-amber-500/5 max-w-3xl mx-auto flex items-start gap-4">
          <ShieldAlert className="w-6 h-6 text-amber-400 shrink-0 mt-1" />
          <div className="text-xs sm:text-sm text-slate-300 space-y-1">
            <h4 className="font-bold text-amber-300 uppercase tracking-wider">Governança Centralizada</h4>
            <p>
              A ativação de novos módulos é gerenciada exclusivamente pelo perfil <strong>ADM Master SDTECH</strong> (<code className="text-amber-200">is_platform_admin</code>), garantindo conformidade contratual, auditoria e estabilidade do ambiente SaaS.
            </p>
          </div>
        </div>

      </div>
    </section>
  );
};
