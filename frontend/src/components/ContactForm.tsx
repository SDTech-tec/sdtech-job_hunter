import React, { useState } from 'react';
import { Send, CheckCircle2, AlertCircle } from 'lucide-react';

export const ContactForm: React.FC = () => {
  const [formData, setFormData] = useState({
    nome: '',
    empresa: '',
    email: '',
    whatsapp: '',
    interesse: 'Plataforma SaaS',
    mensagem: ''
  });

  const [submitted, setSubmitted] = useState(false);
  const [errorMsg, setErrorMsg] = useState('');

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value
    });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    if (!formData.nome || !formData.email || !formData.whatsapp) {
      setErrorMsg('Por favor, preencha os campos obrigatórios (Nome, E-mail e WhatsApp).');
      return;
    }
    setErrorMsg('');

    const subject = encodeURIComponent(`[Contato Landing Page] ${formData.interesse} - ${formData.nome}`);
    const body = encodeURIComponent(
      `Novo contato recebido via Landing Page SDTech Soluctions:\n\n` +
      `Nome: ${formData.nome}\n` +
      `Empresa: ${formData.empresa || 'Não informada'}\n` +
      `E-mail: ${formData.email}\n` +
      `WhatsApp: ${formData.whatsapp}\n` +
      `Interesse: ${formData.interesse}\n\n` +
      `Mensagem / Detalhes:\n${formData.mensagem || 'Nenhuma mensagem adicional.'}`
    );

    window.location.href = `mailto:sdtech.tec@gmail.com?subject=${subject}&body=${body}`;
    setSubmitted(true);
  };

  return (
    <section id="contato" className="py-20 bg-dark-base relative">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        
        <div className="max-w-3xl mx-auto">
          <div className="glass-panel p-8 md:p-12 rounded-3xl border border-slate-700/60 shadow-2xl space-y-8">
            
            <div className="text-center space-y-3">
              <div className="inline-flex items-center gap-2 px-3.5 py-1.5 rounded-full bg-brand-500/10 text-brand-400 text-xs font-bold uppercase tracking-wider border border-brand-500/20">
                Contato Comercial
              </div>
              <h2 className="text-3xl sm:text-4xl font-extrabold text-white">
                Fale com a SDTECH
              </h2>
              <p className="text-sm text-slate-300">
                Preencha o formulário e nossa equipe entrará em contato para apresentar as possibilidades do SDTech Soluctions.
              </p>
            </div>

            {submitted ? (
              <div className="glass-card p-8 rounded-2xl border border-emerald-500/40 bg-emerald-500/10 text-center space-y-4 animate-in fade-in duration-300">
                <CheckCircle2 className="w-12 h-12 text-emerald-400 mx-auto" />
                <h3 className="text-2xl font-bold text-white">Mensagem Enviada!</h3>
                <p className="text-sm text-slate-300 max-w-md mx-auto">
                  Obrigado pelo interesse no <strong>SDTech Soluctions</strong>. Nossa equipe entrará em contato em breve através do WhatsApp/E-mail fornecido.
                </p>
                <button
                  onClick={() => {
                    setSubmitted(false);
                    setFormData({ nome: '', empresa: '', email: '', whatsapp: '', interesse: 'Plataforma SaaS', mensagem: '' });
                  }}
                  className="px-6 py-2.5 rounded-xl bg-slate-800 text-slate-200 hover:text-white text-xs font-semibold border border-slate-700"
                >
                  Enviar outra mensagem
                </button>
              </div>
            ) : (
              <form onSubmit={handleSubmit} className="space-y-6">
                
                {errorMsg && (
                  <div className="p-4 rounded-xl bg-red-500/10 border border-red-500/30 text-red-400 text-xs flex items-center gap-2">
                    <AlertCircle className="w-4 h-4 shrink-0" />
                    <span>{errorMsg}</span>
                  </div>
                )}

                <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                      Nome completo *
                    </label>
                    <input
                      type="text"
                      name="nome"
                      value={formData.nome}
                      onChange={handleChange}
                      placeholder="Seu nome"
                      className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:border-brand-500"
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                      Empresa
                    </label>
                    <input
                      type="text"
                      name="empresa"
                      value={formData.empresa}
                      onChange={handleChange}
                      placeholder="Nome da sua empresa"
                      className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:border-brand-500"
                    />
                  </div>
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-2 gap-6">
                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                      E-mail profissional *
                    </label>
                    <input
                      type="email"
                      name="email"
                      value={formData.email}
                      onChange={handleChange}
                      placeholder="seuemail@empresa.com"
                      className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:border-brand-500"
                      required
                    />
                  </div>

                  <div className="space-y-2">
                    <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                      WhatsApp *
                    </label>
                    <input
                      type="tel"
                      name="whatsapp"
                      value={formData.whatsapp}
                      onChange={handleChange}
                      placeholder="(11) 99999-9999"
                      className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:border-brand-500"
                      required
                    />
                  </div>
                </div>

                <div className="space-y-2">
                  <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                    Principal Interesse
                  </label>
                  <select
                    name="interesse"
                    value={formData.interesse}
                    onChange={handleChange}
                    className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white text-sm focus:outline-none focus:border-brand-500"
                  >
                    <option value="Plataforma SaaS">Plataforma SaaS Modular</option>
                    <option value="Inteligência Artificial">Inteligência Artificial & Agentes</option>
                    <option value="Atendimento">Atendimento WhatsApp</option>
                    <option value="Automação">Automação de Processos</option>
                    <option value="Integrações">Integrações & Webhooks</option>
                    <option value="Outros">Outros Recursos</option>
                  </select>
                </div>

                <div className="space-y-2">
                  <label className="text-xs font-bold text-slate-300 uppercase tracking-wider">
                    Mensagem / Detalhes
                  </label>
                  <textarea
                    name="mensagem"
                    rows={4}
                    value={formData.mensagem}
                    onChange={handleChange}
                    placeholder="Descreva brevemente suas necessidades operacionais..."
                    className="w-full px-4 py-3 rounded-xl bg-slate-900/90 border border-slate-700 text-white placeholder-slate-500 text-sm focus:outline-none focus:border-brand-500"
                  />
                </div>

                <button
                  type="submit"
                  className="w-full py-4 rounded-xl bg-gradient-to-r from-brand-600 to-indigo-600 hover:from-brand-500 hover:to-indigo-500 text-white font-bold text-base shadow-xl shadow-brand-600/30 hover:shadow-brand-500/50 transition-all flex items-center justify-center gap-2"
                >
                  <Send className="w-5 h-5" />
                  Enviar Solicitação para a SDTECH
                </button>

              </form>
            )}

          </div>
        </div>

      </div>
    </section>
  );
};
