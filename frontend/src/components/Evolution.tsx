import React from 'react';
import { Plus, ArrowDown, Cpu } from 'lucide-react';

export const Evolution: React.FC = () => {
  return (
    <section className="py-20 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Escalabilidade Orgânica
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Uma plataforma que evolui com sua empresa.
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            O SDTech Solutions foi concebido para crescer através de módulos. Novos recursos são incorporados como extensões do Core, permitindo que cada empresa utilize somente aquilo que contratou.
          </p>
        </div>

        {/* Visual Modular Tree */}
        <div className="max-w-4xl mx-auto space-y-6 text-center">
          
          {/* Core Foundation Box */}
          <div className="glass-panel p-6 rounded-2xl border border-brand-500/40 bg-brand-500/10 inline-block w-full max-w-md shadow-xl">
            <div className="flex items-center justify-center gap-3">
              <Cpu className="w-6 h-6 text-brand-400" />
              <h3 className="text-xl font-extrabold text-white">CORE SAAS (Base Central)</h3>
            </div>
            <p className="text-xs text-slate-300 mt-1">Multi-Tenant • Usuários • RBAC • Audit Log • PostgreSQL</p>
          </div>

          {/* Down Arrow Indicator */}
          <div className="flex justify-center">
            <div className="w-8 h-8 rounded-full bg-slate-800 flex items-center justify-center text-brand-400 border border-slate-700">
              <ArrowDown className="w-4 h-4" />
            </div>
          </div>

          {/* Modules Grid */}
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4">
            
            <div className="glass-card p-4 rounded-xl border border-slate-800 text-center">
              <span className="text-xs font-bold text-white block">Módulo 01</span>
              <span className="text-[10px] text-brand-400 font-semibold">WhatsApp & Evolution</span>
            </div>

            <div className="glass-card p-4 rounded-xl border border-slate-800 text-center">
              <span className="text-xs font-bold text-white block">Módulo 02</span>
              <span className="text-[10px] text-indigo-400 font-semibold">Supervisor & Agentes IA</span>
            </div>

            <div className="glass-card p-4 rounded-xl border border-slate-800 text-center">
              <span className="text-xs font-bold text-white block">Módulo 03</span>
              <span className="text-[10px] text-emerald-400 font-semibold">Webhooks & Integrações</span>
            </div>

            <div className="glass-card p-4 rounded-xl border border-slate-800 text-center">
              <span className="text-xs font-bold text-white block">Módulo 04</span>
              <span className="text-[10px] text-purple-400 font-semibold">Agendamentos & Nicho</span>
            </div>

          </div>

          {/* Future Modules Plug */}
          <div className="pt-4 flex justify-center">
            <div className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl glass-card border border-dashed border-brand-500/40 text-brand-300 text-xs font-bold uppercase tracking-wider">
              <Plus className="w-4 h-4 text-brand-400" />
              <span>Novos Módulos sob medida em incorporação contínua</span>
            </div>
          </div>

        </div>

      </div>
    </section>
  );
};
