# 📅 Calendário de Tarefas

![Flutter](https://img.shields.io/badge/Flutter-3.22-blue?logo=flutter)
![Firebase](https://img.shields.io/badge/Firebase-Auth%20%26%20Realtime-yellow?logo=firebase)
![Status](https://img.shields.io/badge/status-em%20desenvolvimento-orange)

Aplicativo Flutter para **gerenciamento de tarefas diárias** com visualização em calendário. Utiliza **Firebase Authentication** para login e **Realtime Database** para armazenar tarefas por data, em tempo real.

---

## 🚀 Funcionalidades

- ✅ Cadastro e login com autenticação segura  
- 🗓️ Calendário interativo com seleção de datas (via `TableCalendar`)  
- ✍️ Adição, exclusão e conclusão de tarefas  
- 🔠 Ordenação alfabética das tarefas com prioridade para não concluídas  
- 🔁 Sincronização em tempo real com Firebase  
- 🧹 Remoção em massa das tarefas do dia  

---

## 🛠️ Tecnologias Utilizadas

| 🧪 Tecnologia         | 💡 Descrição                                  |
|-----------------------|-----------------------------------------------|
| **Flutter**           | Framework para desenvolvimento mobile         |
| **Dart**              | Linguagem utilizada no Flutter                |
| **Firebase Auth**     | Autenticação de usuários                      |
| **Firebase Database** | Banco de dados em tempo real                  |
| **TableCalendar**     | Widget de calendário personalizável           |

---

## 📱 Telas do Aplicativo

| Tela              | Descrição                                              |
|-------------------|--------------------------------------------------------|
| **LoginPage**     | Autenticação com email e senha                         |
| **RegisterPage**  | Cadastro de novos usuários                             |
| **CalendarPage**  | Seleção de datas com calendário interativo             |
| **ToDoListPage**  | Lista de tarefas específicas por data com gerenciamento |

---

## 🧩 Estrutura do Projeto

```bash
/lib
├── main.dart             # Inicialização do Firebase e do app
├── login.dart            # Tela de login
├── cadastro.dart         # Tela de cadastro
├── calendarPage.dart     # Calendário com navegação para tarefas
├── todoListPage.dart     # Gerenciamento de tarefas do dia
├── firebase_options.dart # Configurações do Firebase (auto-gerado)
```

# Clone o repositório
git clone https://github.com/seu-usuario/seu-repo.git

# Acesse o diretório
cd seu-repo

# Instale os pacotes
flutter pub get

# Execute o app
flutter run

# ✨ Autor <br>
Desenvolvido com 💙 por Lara Marinho Cordeiro <br>
📧 Contato: [laramaricordeiro@gmail.com](mailto:laramaricordeiro@gmail.com) <br>
🔗 [LinkedIn](https://www.linkedin.com/in/lara-marinho-cordeiro-b77a2b275/) • [GitHub](https://github.com/lahmarinhoh)