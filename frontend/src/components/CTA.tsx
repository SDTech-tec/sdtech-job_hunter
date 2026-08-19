import React from 'react';
import { ArrowRight, MessageSquare } from 'lucide-react';

export const CTA: React.FC = () => {
  return (
    <section className="py-20 bg-dark-surface/60 relative overflow-hidden">
      <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-brand-500/10 rounded-full blur-[140px] pointer-events-none" />

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10 text-center">
        
        <div className="glass-panel p-10 md:p-16 rounded-3xl border border-brand-500/30 max-w-4xl mx-auto space-y-6">
          
          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Pronto para transformar sua operação?
          </h2>

          <p className="text-base sm:text-lg text-slate-300 max-w-2xl mx-auto leading-relaxed">
            Converse com a SDTECH e descubra como o <strong>SDTech Soluctions</strong> pode se adaptar às necessidades da sua empresa.
          </p>

          <div className="flex flex-col sm:flex-row items-center justify-center gap-4 pt-4">
            <a
              href="#contato"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-4 rounded-xl bg-gradient-to-r from-brand-600 to-indigo-600 hover:from-brand-500 hover:to-indigo-500 text-white font-bold text-base shadow-xl shadow-brand-600/30 hover:shadow-brand-500/50 transition-all hover:-translate-y-0.5"
            >
              <MessageSquare className="w-5 h-5" />
              Falar com a SDTECH
            </a>

            <a
              href="#soluctions"
              className="w-full sm:w-auto inline-flex items-center justify-center gap-2 px-8 py-4 rounded-xl glass-card hover:bg-slate-800/80 text-slate-200 hover:text-white font-semibold text-base border border-slate-700 transition-all"
            >
              Conhecer a plataforma
              <ArrowRight className="w-5 h-5" />
            </a>
          </div>

        </div>

      </div>
    </section>
  );
};
