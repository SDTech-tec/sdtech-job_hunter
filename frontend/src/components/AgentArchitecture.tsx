import React from 'react';
import { Network, UserCheck, ShoppingCart, Headset, Sparkles } from 'lucide-react';

export const AgentArchitecture: React.FC = () => {
  return (
    <section id="ia" className="py-20 bg-dark-surface/50 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-indigo-500/10 text-indigo-400 text-xs font-bold uppercase tracking-wider border border-indigo-500/20">
            <Sparkles className="w-3.5 h-3.5" />
            <span>Inteligência Artificial Especializada</span>
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Arquitetura preparada para agentes especializados
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            Uma estrutura de IA projetada de forma evolutiva, na qual a plataforma orquestra múltiplos perfis conforme o contrato e o nicho de atuação.
          </p>
        </div>

        {/* Visual Architecture Diagram */}
        <div className="glass-panel p-8 md:p-12 rounded-3xl border border-slate-700/60 shadow-2xl max-w-4xl mx-auto space-y-12">
          
          {/* Top Supervisor Node */}
          <div className="flex flex-col items-center text-center">
            <div className="w-20 h-20 rounded-2xl bg-gradient-to-tr from-brand-600 to-indigo-600 flex items-center justify-center shadow-xl shadow-brand-500/30 border border-white/20 mb-4 animate-float">
              <Network className="w-10 h-10 text-white" />
            </div>
            
            <h3 className="text-2xl font-extrabold text-white">Supervisor IA</h3>
            <span className="text-xs font-semibold px-3 py-1 rounded-full bg-brand-500/20 text-brand-300 border border-brand-500/30 mt-1">
              Orquestrador Central & Triagem
            </span>
            
            <p className="text-sm text-slate-300 max-w-xl mt-3 leading-relaxed">
              O <strong>Supervisor IA</strong> atua como o orquestrador da plataforma, identificando a intenção da conversa e direcionando cada atendimento para o agente mais adequado ou para o atendimento humano.
            </p>
          </div>

          {/* Connection Lines (Visual Graphic) */}
          <div className="relative flex items-center justify-center">
            <div className="w-full h-0.5 bg-gradient-to-r from-transparent via-brand-500/50 to-transparent max-w-2xl" />
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-4 h-4 rounded-full bg-brand-500 border-4 border-dark-base" />
          </div>

          {/* Child Specialist Agents Grid */}
          <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
            
            {/* Recepcionista IA */}
            <div className="glass-card p-6 rounded-2xl border border-emerald-500/30 bg-emerald-500/5 space-y-3 text-center">
              <div className="w-12 h-12 rounded-xl bg-emerald-500/20 text-emerald-400 flex items-center justify-center mx-auto border border-emerald-500/30">
                <UserCheck className="w-6 h-6" />
              </div>
              <h4 className="text-lg font-bold text-white">Recepcionista IA</h4>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 uppercase tracking-wider">
                Disponível Core V1.0
              </span>
              <p className="text-xs text-slate-400">
                Primeiro atendimento, saudações, coleta de dados e respostas a dúvidas frequentes.
              </p>
            </div>

            {/* Vendedor IA */}
            <div className="glass-card p-6 rounded-2xl border border-indigo-500/20 opacity-90 space-y-3 text-center">
              <div className="w-12 h-12 rounded-xl bg-indigo-500/20 text-indigo-400 flex items-center justify-center mx-auto border border-indigo-500/30">
                <ShoppingCart className="w-6 h-6" />
              </div>
              <h4 className="text-lg font-bold text-white">Vendedor IA</h4>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-400 border border-slate-700 uppercase tracking-wider">
                Evolução do Roadmap
              </span>
              <p className="text-xs text-slate-400">
                Apresentação de produtos, qualificação de leads e apoio ao fluxo de vendas.
              </p>
            </div>

            {/* Suporte IA */}
            <div className="glass-card p-6 rounded-2xl border border-purple-500/20 opacity-90 space-y-3 text-center">
              <div className="w-12 h-12 rounded-xl bg-purple-500/20 text-purple-400 flex items-center justify-center mx-auto border border-purple-500/30">
                <Headset className="w-6 h-6" />
              </div>
              <h4 className="text-lg font-bold text-white">Suporte Técnico IA</h4>
              <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-400 border border-slate-700 uppercase tracking-wider">
                Evolução do Roadmap
              </span>
              <p className="text-xs text-slate-400">
                Atendimento Nível 1 para solução de dúvidas operacionais e técnicas.
              </p>
            </div>

          </div>

          <div className="text-xs text-slate-400 text-center italic border-t border-slate-800/80 pt-6">
            * Apresentação da arquitetura evolutiva. Novos agentes especialistas serão incorporados conforme a evolução dos módulos.
          </div>

        </div>

      </div>
    </section>
  );
};
