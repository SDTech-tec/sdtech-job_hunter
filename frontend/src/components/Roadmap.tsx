import React from 'react';
import { CheckCircle2, Clock, Sparkles } from 'lucide-react';

export const Roadmap: React.FC = () => {
  return (
    <section id="roadmap" className="py-20 bg-dark-surface/50 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
            Roadmap do Produto
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Transparência na evolução
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            Acompanhe o estado de desenvolvimento das nossas capacidades e o futuro da plataforma.
          </p>
        </div>

        {/* 3 Columns: ATUAL | EM DESENVOLVIMENTO | FUTURO */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          
          {/* ATUAL */}
          <div className="glass-card p-6 rounded-3xl border border-emerald-500/40 bg-emerald-500/5 space-y-6">
            <div className="flex items-center justify-between border-b border-emerald-500/20 pb-4">
              <div className="flex items-center gap-2">
                <CheckCircle2 className="w-5 h-5 text-emerald-400" />
                <h3 className="text-xl font-extrabold text-white">ATUAL</h3>
              </div>
              <span className="text-[10px] font-bold px-2.5 py-1 rounded-full bg-emerald-500/20 text-emerald-300 uppercase tracking-wider">
                Pronto & Validado
              </span>
            </div>

            <ul className="space-y-3 text-sm text-slate-200">
              <li className="flex items-start gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <span>Core SaaS V1.0 & PostgreSQL 16</span>
              </li>
              <li className="flex items-start gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <span>Isolamento Multi-Tenant & RBAC</span>
              </li>
              <li className="flex items-start gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <span>Orquestração n8n Core</span>
              </li>
              <li className="flex items-start gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <span>Integração Evolution API & WhatsApp Inbound</span>
              </li>
              <li className="flex items-start gap-2.5">
                <CheckCircle2 className="w-4 h-4 text-emerald-400 shrink-0 mt-0.5" />
                <span>Arquitetura do Supervisor IA</span>
              </li>
            </ul>
          </div>

          {/* EM DESENVOLVIMENTO */}
          <div className="glass-card p-6 rounded-3xl border border-indigo-500/40 bg-indigo-500/5 space-y-6">
            <div className="flex items-center justify-between border-b border-indigo-500/20 pb-4">
              <div className="flex items-center gap-2">
                <Clock className="w-5 h-5 text-indigo-400" />
                <h3 className="text-xl font-extrabold text-white">EM DESENVOLVIMENTO</h3>
              </div>
              <span className="text-[10px] font-bold px-2.5 py-1 rounded-full bg-indigo-500/20 text-indigo-300 uppercase tracking-wider">
                Em Andamento
              </span>
            </div>

            <ul className="space-y-3 text-sm text-slate-200">
              <li className="flex items-start gap-2.5">
                <Clock className="w-4 h-4 text-indigo-400 shrink-0 mt-0.5" />
                <span>Agente Recepcionista IA</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Clock className="w-4 h-4 text-indigo-400 shrink-0 mt-0.5" />
                <span>Agentes Especialistas por Nicho</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Clock className="w-4 h-4 text-indigo-400 shrink-0 mt-0.5" />
                <span>SDTech Support AI (Aprendizagem)</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Clock className="w-4 h-4 text-indigo-400 shrink-0 mt-0.5" />
                <span>Suíte de Testes de Handoff IA</span>
              </li>
            </ul>
          </div>

          {/* FUTURO */}
          <div className="glass-card p-6 rounded-3xl border border-purple-500/30 opacity-90 space-y-6">
            <div className="flex items-center justify-between border-b border-purple-500/20 pb-4">
              <div className="flex items-center gap-2">
                <Sparkles className="w-5 h-5 text-purple-400" />
                <h3 className="text-xl font-extrabold text-white">FUTURO</h3>
              </div>
              <span className="text-[10px] font-bold px-2.5 py-1 rounded-full bg-purple-500/20 text-purple-300 uppercase tracking-wider">
                Roadmap Pleno
              </span>
            </div>

            <ul className="space-y-3 text-sm text-slate-300">
              <li className="flex items-start gap-2.5">
                <Sparkles className="w-4 h-4 text-purple-400 shrink-0 mt-0.5" />
                <span>Novos Canais (Instagram, Telegram, Web Chat)</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Sparkles className="w-4 h-4 text-purple-400 shrink-0 mt-0.5" />
                <span>API REST de Alta Performance em Go</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Sparkles className="w-4 h-4 text-purple-400 shrink-0 mt-0.5" />
                <span>Módulos de Agendamento Clinico & Estética</span>
              </li>
              <li className="flex items-start gap-2.5">
                <Sparkles className="w-4 h-4 text-purple-400 shrink-0 mt-0.5" />
                <span>Recursos Avançados de IA Multimodal</span>
              </li>
            </ul>
          </div>

        </div>

      </div>
    </section>
  );
};
