import React from 'react';
import { MessageCircle, Instagram, Send, Globe, CheckCircle2, Clock } from 'lucide-react';

export const Channels: React.FC = () => {
  return (
    <section className="py-20 bg-dark-surface/40 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-emerald-500/10 text-emerald-400 text-xs font-bold uppercase tracking-wider border border-emerald-500/20">
            Multi-Canalidade
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Conecte sua operação aos canais que seus clientes já utilizam.
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            Comece no WhatsApp com o motor oficial Evolution API e expanda para novos canais conforme a evolução da plataforma.
          </p>
        </div>

        {/* Channels Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          
          {/* WhatsApp (Initial/Active) */}
          <div className="glass-card p-6 rounded-2xl border border-emerald-500/50 bg-emerald-500/5 space-y-4 relative overflow-hidden group">
            <div className="w-12 h-12 rounded-xl bg-emerald-500/20 text-emerald-400 flex items-center justify-center border border-emerald-500/30">
              <MessageCircle className="w-6 h-6" />
            </div>
            
            <div>
              <div className="flex items-center justify-between mb-1">
                <h3 className="text-lg font-bold text-white">WhatsApp</h3>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-emerald-500/20 text-emerald-300 border border-emerald-500/30 uppercase flex items-center gap-1">
                  <CheckCircle2 className="w-3 h-3" />
                  Ativo V1.0
                </span>
              </div>
              <span className="text-xs text-emerald-400 font-semibold">Canal Principal Oficial</span>
            </div>

            <p className="text-xs text-slate-300 leading-relaxed">
              Integração via Evolution API com suporte a webhooks, idempotência e múltiplos números de atendimento.
            </p>
          </div>

          {/* Instagram */}
          <div className="glass-card p-6 rounded-2xl border border-slate-800 opacity-80 space-y-4">
            <div className="w-12 h-12 rounded-xl bg-pink-500/10 text-pink-400 flex items-center justify-center border border-pink-500/20">
              <Instagram className="w-6 h-6" />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <h3 className="text-lg font-bold text-white">Instagram Direct</h3>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-400 border border-slate-700 uppercase flex items-center gap-1">
                  <Clock className="w-3 h-3" />
                  Roadmap
                </span>
              </div>
              <span className="text-xs text-slate-400 font-medium">Arquitetura Futura</span>
            </div>

            <p className="text-xs text-slate-400 leading-relaxed">
              Estrutura preparada para receber mensagens diretas do Instagram e encaminhar para a mesma fila multi-tenant.
            </p>
          </div>

          {/* Telegram */}
          <div className="glass-card p-6 rounded-2xl border border-slate-800 opacity-80 space-y-4">
            <div className="w-12 h-12 rounded-xl bg-sky-500/10 text-sky-400 flex items-center justify-center border border-sky-500/20">
              <Send className="w-6 h-6" />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <h3 className="text-lg font-bold text-white">Telegram</h3>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-400 border border-slate-700 uppercase flex items-center gap-1">
                  <Clock className="w-3 h-3" />
                  Roadmap
                </span>
              </div>
              <span className="text-xs text-slate-400 font-medium">Arquitetura Futura</span>
            </div>

            <p className="text-xs text-slate-400 leading-relaxed">
              Integração planejada para bots de Telegram com reaproveitamento integral dos agentes e regras de negócio.
            </p>
          </div>

          {/* Web Chat Widget */}
          <div className="glass-card p-6 rounded-2xl border border-slate-800 opacity-80 space-y-4">
            <div className="w-12 h-12 rounded-xl bg-indigo-500/10 text-indigo-400 flex items-center justify-center border border-indigo-500/20">
              <Globe className="w-6 h-6" />
            </div>

            <div>
              <div className="flex items-center justify-between mb-1">
                <h3 className="text-lg font-bold text-white">Web Chat Widget</h3>
                <span className="text-[10px] font-bold px-2 py-0.5 rounded bg-slate-800 text-slate-400 border border-slate-700 uppercase flex items-center gap-1">
                  <Clock className="w-3 h-3" />
                  Roadmap
                </span>
              </div>
              <span className="text-xs text-slate-400 font-medium">Arquitetura Futura</span>
            </div>

            <p className="text-xs text-slate-400 leading-relaxed">
              Widget incorporável para sites institucionais e plataformas e-commerce.
            </p>
          </div>

        </div>

      </div>
    </section>
  );
};
