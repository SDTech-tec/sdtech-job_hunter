import React from 'react';
import { HelpCircle, Clock, BookOpen, FileText, CheckCircle2 } from 'lucide-react';

export const SupportAI: React.FC = () => {
  return (
    <section className="py-16 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        <div className="glass-panel rounded-3xl p-8 md:p-10 border border-brand-500/30 bg-gradient-to-r from-dark-surface via-slate-900 to-dark-surface max-w-4xl mx-auto relative overflow-hidden">
          <div className="absolute top-0 right-0 w-64 h-64 bg-brand-500/10 rounded-full blur-3xl pointer-events-none" />

          <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-6 pb-6 border-b border-slate-800">
            <div className="flex items-center gap-4">
              <div className="w-14 h-14 rounded-2xl bg-brand-500/20 text-brand-400 flex items-center justify-center border border-brand-500/30 shrink-0">
                <HelpCircle className="w-8 h-8" />
              </div>
              <div>
                <div className="flex items-center gap-2">
                  <h3 className="text-2xl font-extrabold text-white">SDTech Support AI</h3>
                  <span className="text-xs font-bold px-2.5 py-0.5 rounded-full bg-amber-500/20 text-amber-300 border border-amber-500/30 flex items-center gap-1">
                    <Clock className="w-3 h-3" />
                    Em desenvolvimento
                  </span>
                </div>
                <span className="text-xs font-semibold text-brand-400 uppercase tracking-wider">
                  Agente Interno de Suporte da Plataforma (agent_scope: PLATFORM)
                </span>
              </div>
            </div>
          </div>

          <div className="pt-6 space-y-4">
            <p className="text-sm sm:text-base text-slate-300 leading-relaxed">
              Um agente interno planejado para apoiar usuários da plataforma, auxiliar no onboarding, responder dúvidas e contribuir para a evolução da documentação e da base de conhecimento do <strong>SDTech Solutions</strong>.
            </p>

            <div className="grid grid-cols-1 sm:grid-cols-3 gap-4 pt-2">
              <div className="glass-card p-4 rounded-xl flex items-center gap-3 border border-slate-800">
                <BookOpen className="w-5 h-5 text-brand-400 shrink-0" />
                <span className="text-xs font-semibold text-slate-300">Base de Conhecimento</span>
              </div>

              <div className="glass-card p-4 rounded-xl flex items-center gap-3 border border-slate-800">
                <FileText className="w-5 h-5 text-indigo-400 shrink-0" />
                <span className="text-xs font-semibold text-slate-300">Rascunhos de Onboarding</span>
              </div>

              <div className="glass-card p-4 rounded-xl flex items-center gap-3 border border-slate-800">
                <CheckCircle2 className="w-5 h-5 text-emerald-400 shrink-0" />
                <span className="text-xs font-semibold text-slate-300">Aprendizagem Supervisionada</span>
              </div>
            </div>

            <p className="text-xs text-slate-400 italic pt-2">
              * Recurso interno em desenvolvimento para aprimoramento contínuo da experiência de uso da plataforma.
            </p>
          </div>

        </div>

      </div>
    </section>
  );
};
