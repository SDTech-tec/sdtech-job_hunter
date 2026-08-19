import React from 'react';
import { ArrowRight, Layers, Sparkles, ShieldCheck, Zap } from 'lucide-react';

export const Hero: React.FC = () => {
  return (
    <section className="relative pt-32 pb-20 md:pt-44 md:pb-32 overflow-hidden">
      {/* Background Tech Gradients */}
      <div className="absolute top-1/4 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-brand-500/15 rounded-full blur-[140px] pointer-events-none" />
      <div className="absolute top-1/3 right-10 w-[400px] h-[400px] bg-indigo-500/10 rounded-full blur-[120px] pointer-events-none" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center max-w-4xl mx-auto space-y-6">
          
          {/* Badge */}
          <div className="inline-flex items-center gap-2 px-4 py-2 rounded-full glass-card border border-brand-500/30 text-brand-300 text-xs font-semibold uppercase tracking-wider shadow-inner">
            <Sparkles className="w-4 h-4 text-brand-400 animate-pulse" />
            <span>Uma plataforma. Diversas possibilidades.</span>
          </div>

          {/* Title */}
          <h1 className="text-4xl sm:text-5xl md:text-6xl lg:text-7xl font-extrabold tracking-tight text-white leading-[1.1]">
            Inteligência, automação e tecnologia em{' '}
            <span className="gradient-text">uma única plataforma.</span>
          </h1>

          {/* Subtitle */}
          <p className="text-base sm:text-lg md:text-xl text-slate-300 max-w-3xl mx-auto leading-relaxed font-normal">
            <strong className="text-white font-semibold">SDTech Soluctions</strong> é a plataforma SaaS modular da{' '}
            <span className="text-brand-400 font-semibold">SDTECH</span> criada para transformar processos, atendimento e operações por meio de automação, inteligência artificial e integrações.
          </p>

          {/* CTA Action Buttons */}
          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-4">
            <a
              href="#soluctions"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-3 px-8 py-4 rounded-xl bg-gradient-to-r from-brand-600 via-brand-500 to-indigo-600 hover:from-brand-500 hover:to-indigo-500 text-white font-bold text-base shadow-xl shadow-brand-600/30 hover:shadow-brand-500/50 transition-all hover:-translate-y-0.5"
            >
              Conheça o SDTech Soluctions
              <ArrowRight className="w-5 h-5" />
            </a>

            <a
              href="#contato"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-4 rounded-xl glass-card hover:bg-slate-800/80 text-slate-200 hover:text-white font-semibold text-base border border-slate-700 transition-all"
            >
              Falar com a SDTECH
            </a>
          </div>

          {/* Feature Highlights Strip */}
          <div className="pt-12 grid grid-cols-2 md:grid-cols-4 gap-4 max-w-4xl mx-auto text-left">
            <div className="glass-card p-4 rounded-xl flex items-center gap-3">
              <Layers className="w-5 h-5 text-brand-400 shrink-0" />
              <div>
                <h4 className="text-xs font-bold text-white uppercase tracking-wider">Arquitetura</h4>
                <p className="text-xs text-slate-400">Core SaaS Modular</p>
              </div>
            </div>

            <div className="glass-card p-4 rounded-xl flex items-center gap-3">
              <Zap className="w-5 h-5 text-indigo-400 shrink-0" />
              <div>
                <h4 className="text-xs font-bold text-white uppercase tracking-wider">Orquestração</h4>
                <p className="text-xs text-slate-400">PostgreSQL + n8n</p>
              </div>
            </div>

            <div className="glass-card p-4 rounded-xl flex items-center gap-3">
              <Sparkles className="w-5 h-5 text-emerald-400 shrink-0" />
              <div>
                <h4 className="text-xs font-bold text-white uppercase tracking-wider">Agentes IA</h4>
                <p className="text-xs text-slate-400">Supervisor & Especialistas</p>
              </div>
            </div>

            <div className="glass-card p-4 rounded-xl flex items-center gap-3">
              <ShieldCheck className="w-5 h-5 text-purple-400 shrink-0" />
              <div>
                <h4 className="text-xs font-bold text-white uppercase tracking-wider">Isolamento</h4>
                <p className="text-xs text-slate-400">Multi-Tenant Estrito</p>
              </div>
            </div>
          </div>

        </div>
      </div>
    </section>
  );
};
