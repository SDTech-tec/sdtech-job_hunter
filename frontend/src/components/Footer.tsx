import React from 'react';

export const Footer: React.FC = () => {
  return (
    <footer className="bg-dark-base border-t border-slate-800 text-slate-400 text-sm py-12">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 space-y-8">
        
        <div className="flex flex-col md:flex-row items-start md:items-center justify-between gap-6">
          
          {/* Logo & Slogan */}
          <div className="space-y-2">
            <div className="flex items-center gap-3">
              <div className="w-8 h-8 rounded-lg bg-slate-900/90 border border-slate-700/80 p-0.5 flex items-center justify-center overflow-hidden">
                <img src="/assets/sdtech-logo.png" alt="SDTECH Logo" className="w-full h-full object-contain" />
              </div>
              <span className="text-lg font-extrabold text-white tracking-tight">SDTECH</span>
            </div>
            <p className="text-xs text-slate-400">
              Inteligência que transforma operações.
            </p>
          </div>

          {/* Links */}
          <div className="flex flex-wrap items-center gap-6 text-xs font-medium">
            <a href="#empresa" className="hover:text-brand-400 transition-colors">Empresa</a>
            <a href="#soluctions" className="hover:text-brand-400 transition-colors">SDTech Soluctions</a>
            <a href="#contato" className="hover:text-brand-400 transition-colors">Contato</a>
            <a href="#privacidade" onClick={(e) => { e.preventDefault(); alert("Política de Privacidade do SDTech Soluctions"); }} className="hover:text-brand-400 transition-colors">Política de Privacidade</a>
            <a href="#termos" onClick={(e) => { e.preventDefault(); alert("Termos de Uso do SDTech Soluctions"); }} className="hover:text-brand-400 transition-colors">Termos de Uso</a>
          </div>

        </div>

        <div className="border-t border-slate-800/80 pt-6 flex flex-col sm:flex-row items-center justify-between text-[11px] text-slate-500 gap-2">
          <span>© {new Date().getFullYear()} SDTECH — Todos os direitos reservados.</span>
          <span>SDTech Soluctions • Plataforma SaaS Modular</span>
        </div>

      </div>
    </footer>
  );
};
