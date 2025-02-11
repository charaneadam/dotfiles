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
				rep(1), -- this node repeats insert node i(1)
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
		{ trig = ";bm", snippetType = "autosnippet" },
		fmta(
			[[
      \bm{<>}
    ]],
			{
				i(0),
			}
		)
	),

  s(
		{ trig = ";bf", snippetType = "autosnippet" },
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
		{ trig = ";it", snippetType = "autosnippet" },
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
		{ trig = ";bb", snippetType = "autosnippet" },
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
		{ trig = ";cal", snippetType = "autosnippet" },
		fmta(
			[[
      \mathcal{<>}
    ]],
			{
				i(0),
			}
		)
	),
}
