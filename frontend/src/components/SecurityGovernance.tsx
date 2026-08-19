import React from 'react';
import { ShieldCheck, Lock, FileKey, Database, KeyRound, CheckSquare } from 'lucide-react';

export const SecurityGovernance: React.FC = () => {
  return (
    <section className="py-20 bg-dark-surface/40 relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        {/* Header */}
        <div className="text-center max-w-3xl mx-auto space-y-4 mb-16">
          <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-cyan-500/10 text-cyan-400 text-xs font-bold uppercase tracking-wider border border-cyan-500/20">
            Segurança & Governança
          </div>

          <h2 className="text-3xl sm:text-4xl lg:text-5xl font-extrabold text-white tracking-tight">
            Arquitetura preparada para empresas
          </h2>

          <p className="text-base sm:text-lg text-slate-300">
            Projetada desde a primeira linha de código para atender aos padrões rigorosos de isolamento, auditoria e controle de acesso corporativo.
          </p>
        </div>

        {/* 6 Security Cards */}
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
          
          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <ShieldCheck className="w-8 h-8 text-cyan-400" />
            <h3 className="text-lg font-bold text-white">Isolamento Multi-Tenant</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Triggers de validação no banco de dados que impedem o vínculo cruzado entre dados de clientes diferentes.
            </p>
          </div>

          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <Lock className="w-8 h-8 text-brand-400" />
            <h3 className="text-lg font-bold text-white">Controle de Acesso RBAC</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Matriz de permissões granulares por papel (Owner, Admin, Manager, Attendant) e perfil ADM Master SDTECH.
            </p>
          </div>

          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <FileKey className="w-8 h-8 text-indigo-400" />
            <h3 className="text-lg font-bold text-white">Auditoria Imutável</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Tabela de audit logs imutáveis para rastreabilidade de todas as ações relevantes do sistema.
            </p>
          </div>

          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <Database className="w-8 h-8 text-emerald-400" />
            <h3 className="text-lg font-bold text-white">PostgreSQL Enterprise</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Identificadores nativos UUID v4, campos semi-estruturados JSONB e controle de migrations versionadas.
            </p>
          </div>

          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <KeyRound className="w-8 h-8 text-purple-400" />
            <h3 className="text-lg font-bold text-white">Privilégios Mínimos</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Uso da conta de aplicação com permissões restritas DML (`sdtech_app`), sem acesso DDL ou superuser.
            </p>
          </div>

          <div className="glass-card p-6 rounded-2xl border border-slate-800 space-y-3">
            <CheckSquare className="w-8 h-8 text-amber-400" />
            <h3 className="text-lg font-bold text-white">Controle de Módulos</h3>
            <p className="text-xs text-slate-400 leading-relaxed">
              Habilitação transparente dos módulos de acordo com o contrato celebrado por cada empresa.
            </p>
          </div>

        </div>

      </div>
    </section>
  );
};
