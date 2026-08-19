import React from 'react';
import { Target, Cpu, TrendingUp, CheckCircle2 } from 'lucide-react';

export const AboutSDTech: React.FC = () => {
  return (
    <section id="empresa" className="py-20 bg-dark-surface/50 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          
          {/* Text Content */}
          <div className="space-y-6">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
              Sobre a SDTECH
            </div>

            <h2 className="text-3xl sm:text-4xl font-extrabold text-white tracking-tight leading-tight">
              Tecnologia focada em eficiência, escalabilidade e resultados reais.
            </h2>

            <p className="text-base sm:text-lg text-slate-300 leading-relaxed">
              A <strong className="text-white font-semibold">SDTECH</strong> é uma empresa de tecnologia focada no desenvolvimento de soluções digitais, automação, inteligência artificial, integrações e plataformas SaaS.
            </p>

            <p className="text-base text-slate-400 leading-relaxed">
              Criamos tecnologia com foco em eficiência, escalabilidade e resultados reais para empresas, desenvolvendo arquiteturas robustas preparadas para a transformação digital.
            </p>

            {/* Pillar Bullets */}
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 pt-4">
              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-brand-400 shrink-0 mt-0.5" />
                <div>
                  <h4 className="text-sm font-bold text-white">Plataformas SaaS</h4>
                  <p className="text-xs text-slate-400">Arquiteturas modulares e multi-tenant.</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-indigo-400 shrink-0 mt-0.5" />
                <div>
                  <h4 className="text-sm font-bold text-white">Inteligência Artificial</h4>
                  <p className="text-xs text-slate-400">Agentes e orquestração inteligente.</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-emerald-400 shrink-0 mt-0.5" />
                <div>
                  <h4 className="text-sm font-bold text-white">Automação de Processos</h4>
                  <p className="text-xs text-slate-400">Workflows e integração de sistemas.</p>
                </div>
              </div>

              <div className="flex items-start gap-3">
                <CheckCircle2 className="w-5 h-5 text-purple-400 shrink-0 mt-0.5" />
                <div>
                  <h4 className="text-sm font-bold text-white">Segurança Enterprise</h4>
                  <p className="text-xs text-slate-400">Isolamento estrito e auditoria.</p>
                </div>
              </div>
            </div>

          </div>

          {/* Visual Card / Graphics */}
          <div className="relative">
            <div className="glass-panel rounded-2xl p-8 space-y-6 border border-slate-700/60 shadow-2xl relative overflow-hidden">
              <div className="absolute top-0 right-0 w-32 h-32 bg-brand-500/10 rounded-full blur-2xl pointer-events-none" />

              <div className="flex items-center gap-4 border-b border-slate-800 pb-6">
                <div className="w-12 h-12 rounded-xl bg-brand-500/20 border border-brand-500/30 flex items-center justify-center text-brand-400">
                  <Cpu className="w-6 h-6" />
                </div>
                <div>
                  <h3 className="text-lg font-bold text-white">SDTECH Ecosystem</h3>
                  <p className="text-xs text-slate-400">Hub de tecnologia e plataformas SaaS</p>
                </div>
              </div>

              <div className="space-y-4">
                <div className="glass-card p-4 rounded-xl flex items-center justify-between border border-brand-500/30 bg-brand-500/5">
                  <div className="flex items-center gap-3">
                    <Target className="w-5 h-5 text-brand-400" />
                    <span className="text-sm font-bold text-white">1. SDTech Soluctions</span>
                  </div>
                  <span className="text-xs font-semibold px-2.5 py-1 rounded-md bg-brand-500/20 text-brand-300">Plataforma Principal</span>
                </div>

                <div className="glass-card p-4 rounded-xl flex items-center justify-between opacity-80">
                  <div className="flex items-center gap-3">
                    <TrendingUp className="w-5 h-5 text-slate-400" />
                    <span className="text-sm font-semibold text-slate-300">2. Novos Produtos & Projetos</span>
                  </div>
                  <span className="text-xs font-medium text-slate-400">Roadmap Futuro</span>
                </div>
              </div>

              <div className="pt-2 text-xs text-slate-400 text-center italic border-t border-slate-800">
                "Estrutura oficial focada na excelência contínua do SDTech Soluctions."
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>
  );
};
