import React from 'react';
import { Webhook, Code2, Workflow, Share2 } from 'lucide-react';

export const Integrations: React.FC = () => {
  return (
    <section id="integracoes" className="py-20 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-12 items-center">
          
          {/* Text Content */}
          <div className="space-y-6">
            <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-purple-500/10 text-purple-400 text-xs font-bold uppercase tracking-wider border border-purple-500/20">
              Conectividade Flexível
            </div>

            <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
              Conecte o SDTech Soluctions ao seu ecossistema.
            </h2>

            <p className="text-base sm:text-lg text-slate-300 leading-relaxed">
              Desenvolvido com mentalidade API-first, a plataforma permite sincronização em tempo real de eventos e dados através de webhooks, automações e APIs de alta disponibilidade.
            </p>

            <div className="space-y-4 pt-2">
              <div className="flex items-start gap-4">
                <div className="w-10 h-10 rounded-xl bg-purple-500/20 text-purple-400 flex items-center justify-center shrink-0 border border-purple-500/30">
                  <Webhook className="w-5 h-5" />
                </div>
                <div>
                  <h4 className="text-base font-bold text-white">Webhooks Reativos</h4>
                  <p className="text-xs sm:text-sm text-slate-400">Notificações em tempo real para disparar ações em CRMs, ERPs e ferramentas proprietárias.</p>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-10 h-10 rounded-xl bg-indigo-500/20 text-indigo-400 flex items-center justify-center shrink-0 border border-indigo-500/30">
                  <Workflow className="w-5 h-5" />
                </div>
                <div>
                  <h4 className="text-base font-bold text-white">Orquestração n8n</h4>
                  <p className="text-xs sm:text-sm text-slate-400">Criação de workflows customizados para tratamento de dados, regras condicionais e retentativas.</p>
                </div>
              </div>

              <div className="flex items-start gap-4">
                <div className="w-10 h-10 rounded-xl bg-brand-500/20 text-brand-400 flex items-center justify-center shrink-0 border border-brand-500/30">
                  <Code2 className="w-5 h-5" />
                </div>
                <div>
                  <h4 className="text-base font-bold text-white">Futura API REST em Go</h4>
                  <p className="text-xs sm:text-sm text-slate-400">Roadmap previsto para exposição de endpoints de alta vazão para integrações nativas.</p>
                </div>
              </div>
            </div>
          </div>

          {/* Visual Diagram */}
          <div className="glass-panel p-8 rounded-3xl border border-slate-700/60 shadow-2xl relative">
            <div className="text-center space-y-6">
              
              <div className="w-16 h-16 rounded-2xl bg-gradient-to-tr from-purple-600 to-indigo-600 flex items-center justify-center mx-auto shadow-lg shadow-purple-500/20">
                <Share2 className="w-8 h-8 text-white" />
              </div>

              <h3 className="text-xl font-extrabold text-white">Hub de Integrações SDTech</h3>

              <div className="grid grid-cols-2 gap-3 pt-2">
                <div className="glass-card p-3 rounded-xl border border-slate-800 text-center">
                  <span className="text-xs font-bold text-brand-300 block">CRMs & Vendas</span>
                  <span className="text-[10px] text-slate-400">Webhooks Inbound/Outbound</span>
                </div>

                <div className="glass-card p-3 rounded-xl border border-slate-800 text-center">
                  <span className="text-xs font-bold text-indigo-300 block">ERPs & Financeiro</span>
                  <span className="text-[10px] text-slate-400">Notificações e Status</span>
                </div>

                <div className="glass-card p-3 rounded-xl border border-slate-800 text-center">
                  <span className="text-xs font-bold text-emerald-300 block">Plataformas SaaS</span>
                  <span className="text-[10px] text-slate-400">Integração de Contatos</span>
                </div>

                <div className="glass-card p-3 rounded-xl border border-slate-800 text-center">
                  <span className="text-xs font-bold text-purple-300 block">Banco de Dados</span>
                  <span className="text-[10px] text-slate-400">PostgreSQL Core V1.0</span>
                </div>
              </div>

            </div>
          </div>

        </div>

      </div>
    </section>
  );
};
