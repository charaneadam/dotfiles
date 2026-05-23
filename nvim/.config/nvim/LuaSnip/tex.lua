return {
	s(
		{ trig = ";env", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1),
			}
		)
	),

	s(
		{ trig = ";ul", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{itemize}
          \item <>
      \end{itemize}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";ol", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{enumerate}
          \item <>
      \end{enumerate}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";b", snippetType = "autosnippet" },
		fmta(
			[[
      \textbf{<>}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";i", snippetType = "autosnippet" },
		fmta(
			[[
      \textit{<>}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";O", snippetType = "autosnippet" },
		fmta(
			[[
      \mathcal{O}(<>)
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";mb", snippetType = "autosnippet" },
		fmta(
			[[
      \mathbb{<>}
    ]],
			{
				i(0),
			}
		)
	),

	s(
		{ trig = ";mc", snippetType = "autosnippet" },
		fmta(
			[[
      \mathcal{<>}
    ]],
			{
				i(0),
			}
		)
	),

  s(
	{ trig = ";doc", snippetType = "autosnippet" },
	fmta(
		[[
\documentclass[<>]{article}

% ---------- Packages ----------
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
\usepackage{lmodern}

\usepackage{amsmath, amssymb, amsthm}
\usepackage{mathtools}
\usepackage{physics}

\usepackage{graphicx}
\usepackage{booktabs}
\usepackage{hyperref}

% ---------- Metadata ----------
\title{<>}
\author{<>}
\date{<>}

\begin{document}

\maketitle

\begin{abstract}
<>
\end{abstract}

\section{<>}
<>

\end{document}
]],
		{
			i(1, "11pt"),
			i(2, "Title"),
			i(3, "Author"),
			i(4, "\\today"),
			i(5, "Abstract goes here."),
			i(6, "Introduction"),
			i(0),
		}
	)
),

}
