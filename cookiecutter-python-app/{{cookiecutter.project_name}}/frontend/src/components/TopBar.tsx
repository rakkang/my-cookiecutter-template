export function TopBar() {
  return (
    <header className="h-16 bg-white border-b border-gray-200 flex items-center justify-between px-6">
      <div className="flex items-center gap-4">
        <h1 className="text-xl font-semibold text-gray-800">{{ cookiecutter.project_name }}</h1>
      </div>
      <div className="flex items-center gap-4">
        <span className="text-sm text-gray-600">用户</span>
      </div>
    </header>
  )
}
